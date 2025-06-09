<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Jadwal;
use App\Models\User;

class JadwalController extends Controller
{
    public function index() {
        return Jadwal::with(['kelas', 'subject', 'guru'])->get();
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'kelas_id' => 'required|exists:kelas,id',
            'subject_id' => 'required|exists:subjects,id',
            'guru_id' => 'required|exists:users,id',
            'hari' => 'required|string',
            'jam_mulai' => 'required|date_format:H:i',
            'jam_selesai' => 'required|date_format:H:i|after:jam_mulai',
        ]);
        $Jadwal = Jadwal::create($validated);

        $Jadwal->load(['kelas', 'subject', 'guru']);

        return response()->json($Jadwal, 201);
    }

    public function show($id) {
        return Jadwal::with(['kelas', 'subject', 'guru'])->findOrFail($id);
    }

    public function update(Request $request, $id) {
        $Jadwal = Jadwal::findOrFail($id);
        $validated = $request->validate([
            'kelas_id' => 'required|exists:kelas,id',
            'subject_id' => 'required|exists:subjects,id',
            'guru_id' => 'required|exists:users,id',
            'hari' => 'required|string',
            'jam_mulai' => 'required|date_format:H:i',
            'jam_selesai' => 'required|date_format:H:i|after:jam_mulai',
        ]);
        $Jadwal->update($validated);

        $Jadwal->load(['kelas', 'subject', 'guru']);

        return response()->json($Jadwal);
    }

    public function destroy($id) {
        Jadwal::findOrFail($id)->delete();
        return response()->json(null, 204);
    }

    public function getJadwalGuru($id)
    {
        // Pastikan user yang meminta adalah guru
        $user = User::with('role')->findOrFail($id);

        if (!$user || strtolower($user->role->name) !== 'guru') {
            return response()->json([
                'message' => 'Unauthorized. Only teachers can access this resource.'
            ], 403);
        }

        // Ambil jadwal berdasarkan guru_id
        $jadwals = Jadwal::with(['kelas', 'subject', 'guru'])
            ->where('guru_id', $id)
            ->get();

        // Tambahkan nextDate dan kembalikan format yang disederhanakan
        $jadwalsWithDate = $jadwals->map(function ($j) {
            // Hitung tanggal berikutnya berdasarkan hari
            $nextDate = now()->startOfWeek()->addDays([
                'Senin' => 0,
                'Selasa' => 1,
                'Rabu' => 2,
                'Kamis' => 3,
                'Jumat' => 4,
                'Sabtu' => 5,
                'Minggu' => 6,
            ][$j->hari] ?? 0);

            if ($nextDate->isPast()) {
                $nextDate->addWeek();
            }

            return [
                'id' => $j->id,
                'tanggal' => $nextDate->toDateString(),
                'hari' => $j->hari,
                'jam_mulai' => $j->jam_mulai,
                'jam_selesai' => $j->jam_selesai,
                'kelas' => $j->kelas,
                'subject' => $j->subject,
                'guru' => $j->guru,
                'path' => '/kelas/' . $j->id,
                'nextDate' => $nextDate->toDateString(),
            ];
        })->sortBy('nextDate')->values();

        return response()->json($jadwalsWithDate);
    }

}
