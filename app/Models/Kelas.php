<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\User;
use App\Models\Jadwal;

class Kelas extends Model
{
    protected $fillable = ['name'];

    public function users() {
        return $this->hasMany(User::class);
    }

    public function jadwal() {
        return $this->hasMany(Jadwal::class);
    }
}
