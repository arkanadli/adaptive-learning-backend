<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Quiz extends Model
{
    protected $fillable = [
        'jadwal_id',
        'title',
        'description'
    ];

    public function jadwal() {
        return $this->belongsTo(Jadwal::class);
    }

    public function questions() {
        return $this->hasMany(Question::class);
    }
}
