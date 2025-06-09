<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

// Model yang dibutuhkan
use App\Models\User;
use App\Models\Kelas;
use App\Models\Subject;
use App\Models\Jadwal;
use App\Models\Absensi;

class DashboardController extends Controller
{

    public function getUsersCount()
    {
        // Asumsi: User memiliki kolom role_id → FK ke tabel roles
        // Role model memiliki field 'name' (misal 'admin', 'guru', 'siswa')
        $totalUsers  = User::count();
        $totalAdmin  = User::whereHas('role', fn($q) => $q->where('name', 'admin'))->count();
        $totalGuru   = User::whereHas('role', fn($q) => $q->where('name', 'guru'))->count();
        $totalSiswa  = User::whereHas('role', fn($q) => $q->where('name', 'siswa'))->count();

        return response()->json([
            'totalUsers' => $totalUsers,
            'totalAdmin' => $totalAdmin,
            'totalGuru'  => $totalGuru,
            'totalSiswa' => $totalSiswa,
        ]);
    }

    public function getKelasCount()
    {
        $count = Kelas::count();
        return response()->json(['count' => $count]);
    }

    public function getSubjekCount()
    {
        $count = Subject::count();
        return response()->json(['count' => $count]);
    }

    public function getAttendanceSummary()
    {
        $today = Carbon::today();
        $hadir = Absensi::whereDate('tanggal', $today)
                        ->where('status', 'hadir')
                        ->count();
        $total = Absensi::whereDate('tanggal', $today)->count();

        return response()->json([
            'hadir' => $hadir,
            'total' => $total,
        ]);
    }

    public function getRoleDistribution()
    {
        // Join dengan tabel roles, group by role name
        $distribution = User::select('roles.name as role', DB::raw('count(users.id) as jumlah'))
            ->join('roles', 'users.role_id', '=', 'roles.id')
            ->groupBy('roles.name')
            ->get();

        // Pastikan output seperti: [{ role: "admin", jumlah: 2 }, { role: "guru", jumlah: 45 }, ...]
        return response()->json($distribution);
    }

    public function getUpcomingSchedule(Request $request)
    {
        $limit = intval($request->query('limit', 5));
        if ($limit <= 0) {
            $limit = 5;
        }

        $daysMap = [
            'Senin' => 1,
            'Selasa' => 2,
            'Rabu' => 3,
            'Kamis' => 4,
            'Jumat' => 5,
            'Sabtu' => 6,
            'Minggu' => 7,
        ];

        $todayNum = intval(Carbon::now()->isoFormat('E')); // 1..7

        // Ambil semua jadwal dengan relasi
        $jadwals = Jadwal::with(['kelas:id,name', 'subject:id,name', 'guru:id,name'])->get();

        // Map jadwal dengan hitung tanggal aktual berikutnya dari hari jadwal
        $jadwalsWithDate = $jadwals->map(function ($j) use ($daysMap, $todayNum) {
            $jadwalHariNum = $daysMap[$j->hari] ?? null;
            if ($jadwalHariNum === null) {
                return null; // skip kalau hari tidak valid
            }

            // Hitung selisih hari dari hari sekarang ke hari jadwal
            $diffDays = $jadwalHariNum - $todayNum;
            if ($diffDays < 0) {
                // Kalau jadwal sudah lewat minggu ini, ambil hari minggu depan
                $diffDays += 7;
            }

            // Tanggal aktual jadwal berikutnya
            $nextDate = Carbon::now()->addDays($diffDays)->toDateString();

            return [
                'id' => $j->id,
                'tanggal' => $nextDate,
                'hari' => $j->hari,
                'jam_mulai' => $j->jam_mulai,
                'jam_selesai' => $j->jam_selesai,
                'kelas' => $j->kelas->name,
                'subject' => $j->subject->name,
                'guru' => $j->guru->name,
                'nextDate' => $nextDate,  // untuk sorting
            ];
        })->filter()->sortBy('nextDate')->take($limit)->values();

        return response()->json($jadwalsWithDate);
    }


    public function getAttendanceTrend()
    {
        $today = Carbon::today();
        $data = [];

        for ($i = 6; $i >= 0; $i--) {
            $date = $today->copy()->subDays($i)->toDateString(); // e.g. '2025-06-05'
            $total  = Absensi::where('tanggal', $date)->count();
            $hadir  = Absensi::where('tanggal', $date)
                             ->where('status', 'hadir')
                             ->count();
            $percentage = $total > 0 ? round(($hadir / $total) * 100) : 0;
            $data[] = [
                'tanggal'    => $date,
                'persentase' => $percentage,
            ];
        }

        return response()->json($data);
    }
}
