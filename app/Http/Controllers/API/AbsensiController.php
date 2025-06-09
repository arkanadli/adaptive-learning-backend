<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Absensi;

class AbsensiController extends Controller
{
    public function index() {
        return Absensi::with(['jadwalUser.user', 'jadwalUser.jadwal.kelas', 'jadwalUser.jadwal.subject', 'jadwalUser.jadwal.guru'])->get();
    }

    public function store(Request $request) {

        $validated = $request->validate([
            'jadwal_user_id' => 'required|exists:jadwal_users,id',
            'tanggal' => 'required|date_format:Y-m-d H:i:s',
            'status' => 'required|in:hadir,izin,sakit,alpa',
        ]);

        $Absensi = Absensi::create($validated);

        $Absensi->load(['jadwalUser.user', 'jadwalUser.jadwal.kelas', 'jadwalUser.jadwal.subject', 'jadwalUser.jadwal.guru']);

        return response()->json($Absensi, 201);
    }

    public function show($id) {
        return Absensi::findOrFail($id);
    }

    public function update(Request $request, $id) {

        $Absensi = Absensi::findOrFail($id);

        $validated = $request->validate([
            'tanggal' => 'required|date_format:Y-m-d H:i:s',
            'status' => 'required|in:hadir,izin,sakit,alpa',
        ]);

        $Absensi->update($validated);

        $Absensi->load(['jadwalUser.user', 'jadwalUser.jadwal.kelas', 'jadwalUser.jadwal.subject', 'jadwalUser.jadwal.guru']);

        return response()->json($Absensi);
    }

    public function destroy($id) {
        Absensi::findOrFail($id)->delete();
        return response()->json(null, 204);
    }

    public function absensiByJadwal($id, Request $request)
    {
        $query = Absensi::whereHas('jadwalUser.jadwal', function ($query) use ($id) {
            $query->where('id', $id);
        })
        ->with([
            'jadwalUser.jadwal.kelas',
            'jadwalUser.jadwal.subject',
            'jadwalUser.jadwal.guru',
            'jadwalUser.user.role'
        ]);

        if ($request->has('user_id')) {
            $query->whereHas('jadwalUser.user', function ($q) use ($request) {
                $q->where('id', $request->user_id);
            });
        }

        $answers = $query->get();

        return response()->json($answers);
    }
}
