<?php

namespace App\Models;

use App\Models\User;
use App\Models\Question;
use Illuminate\Database\Eloquent\Model;

class UserAnswer extends Model
{
    protected $fillable = [
        'user_id',
        'question_id',
        'selected_answer',
        'is_correct',
        'attempt_number',
    ];

    public function user() {
        return $this->belongsTo(User::class);
    }

    public function question() {
        return $this->belongsTo(Question::class);
    }
}
