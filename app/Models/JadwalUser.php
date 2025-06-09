<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JadwalUser extends Model
{
    protected $fillable = [
        'jadwal_id',
        'user_id',
        'difficulty_level',
    ];

    public function jadwal()
    {
        return $this->belongsTo(Jadwal::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
