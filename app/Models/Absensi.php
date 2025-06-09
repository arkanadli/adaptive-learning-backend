<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Absensi extends Model
{
    protected $fillable = [
        'jadwal_user_id',
        'tanggal',
        'status'
    ];

    public function jadwalUser() {
        return $this->belongsTo(JadwalUser::class);
    }
}
