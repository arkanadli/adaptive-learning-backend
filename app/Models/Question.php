<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
    protected $fillable = [
        'quiz_id',
        'question_text',
        'options',
        'correct_answer',
        'difficulty_level'
    ];

    protected $casts = [
        'options' => 'array'
    ];

    public function quiz() {
        return $this->belongsTo(Quiz::class);
    }

    public function answers() {
        return $this->hasMany(UserAnswer::class);
    }
}
