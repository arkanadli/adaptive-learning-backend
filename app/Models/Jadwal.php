<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Jadwal extends Model
{
    protected $fillable = [
        'kelas_id',
        'subject_id',
        'guru_id',
        'hari',
        'jam_mulai',
        'jam_selesai'
    ];

    public function kelas() {
        return $this->belongsTo(Kelas::class);
    }

    public function subject() {
        return $this->belongsTo(Subject::class);
    }

    public function guru() {
        return $this->belongsTo(User::class, 'guru_id');
    }

    public function materi() {
        return $this->hasMany(Materi::class);
    }

    public function quiz() {
        return $this->hasMany(Quiz::class);
    }
}
