<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\JadwalUser;
use App\Models\User;

class JadwalUserController extends Controller
{
    public function index() {
        return JadwalUser::with(['jadwal.kelas', 'jadwal.subject', 'jadwal.guru', 'user.role'])->get();
    }

    public function store(Request $request) {

        $validated = $request->validate([
            'jadwal_id' => 'required|exists:jadwals,id',
            'user_id' => 'required|exists:users,id',
            'difficulty_level' => 'required|in:1,2,3',
        ]);

        $enrollment = JadwalUser::create($validated);

        $enrollment->load(['jadwal.kelas', 'jadwal.subject', 'jadwal.guru', 'user.role']);

        return response()->json($enrollment, 201);
    }

    public function show($id) {
        return JadwalUser::with(['jadwal.kelas', 'jadwal.subject', 'jadwal.guru', 'user.role'])->findOrFail($id);
    }

    public function update(Request $request, $id) {

        $enrollment = JadwalUser::findOrFail($id);

        $validated = $request->validate([
            'jadwal_id' => 'required|exists:jadwals,id',
            'user_id' => 'required|exists:users,id',
            'difficulty_level' => 'required|in:1,2,3',
        ]);

        $enrollment->update($validated);

        $enrollment->load(['jadwal.kelas', 'jadwal.subject', 'jadwal.guru', 'user.role']);

        return response()->json($enrollment);
    }

    public function destroy($id) {
        JadwalUser::findOrFail($id)->delete();
        return response()->json(null, 204);
    }

    public function userByJadwal($id) {
        return JadwalUser::where('jadwal_id', $id)->with(['jadwal.kelas', 'jadwal.subject', 'jadwal.guru', 'user.role'])->get();
    }

    public function getIdByJadwalUser(Request $request) {
        $validated = $request->validate([
            'jadwal_id' => 'required|integer|exists:jadwals,id',
            'user_id' => 'required|integer|exists:users,id',
        ]);

        return JadwalUser::where('jadwal_id', $validated['jadwal_id'])
            ->where('user_id', $validated['user_id'])
            ->with(['jadwal.kelas', 'jadwal.subject', 'jadwal.guru', 'user.role'])
            ->get();
    }

    public function getJadwalSiswa($id)
    {

        $user = User::with('role')->findOrFail($id);

        if (!$user || strtolower($user->role->name) !== 'siswa') {
            return response()->json([
                'message' => 'Unauthorized. Only Siswa can access this resource.'
            ], 403);
        }

        $jadwals = JadwalUser::with(['jadwal.kelas', 'jadwal.subject', 'jadwal.guru', 'user.role'])
            ->where('user_id', $id)
            ->get();

        $jadwalsWithDate = $jadwals->map(function ($j) {
            $nextDate = now()->startOfWeek()->addDays([
                'Senin' => 0,
                'Selasa' => 1,
                'Rabu' => 2,
                'Kamis' => 3,
                'Jumat' => 4,
                'Sabtu' => 5,
                'Minggu' => 6,
            ][$j->jadwal->hari] ?? 0);

            if ($nextDate->isPast()) {
                $nextDate->addWeek();
            }

            return [
                'id' => $j->jadwal->id,
                'tanggal' => $nextDate->toDateString(),
                'hari' => $j->jadwal->hari,
                'jam_mulai' => $j->jadwal->jam_mulai,
                'jam_selesai' => $j->jadwal->jam_selesai,
                'kelas' => $j->jadwal->kelas,
                'subject' => $j->jadwal->subject,
                'guru' => $j->jadwal->guru,
                'path' => '/kelas/' . $j->jadwal->id,
                'nextDate' => $nextDate->toDateString(),
            ];
        })->sortBy('nextDate')->values();

        return response()->json($jadwalsWithDate);
    }
}
