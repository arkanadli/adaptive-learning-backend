<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\Subject;
use App\Models\User;

class Materi extends Model
{
    protected $fillable = [
        'jadwal_id',
        'title',
        'description',
        'difficulty_level',
        'file_name',
        'file_path'
    ];

    public function jadwal() {
        return $this->belongsTo(Jadwal::class);
    }

}
