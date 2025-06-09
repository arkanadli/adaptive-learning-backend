<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\Materi;
use App\Models\Jadwal;

class Subject extends Model
{
    protected $fillable = [
        'name',
        'code',
        'singkatan',
    ];

    public function materi() {
        return $this->hasMany(Materi::class);
    }

    public function jadwal() {
        return $this->hasMany(Jadwal::class);
    }
}
