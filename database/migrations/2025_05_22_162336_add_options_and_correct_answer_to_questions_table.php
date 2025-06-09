<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up() {
        Schema::table('questions', function (Blueprint $table) {
            $table->json('options')->after('question_text');
            $table->string('correct_answer')->after('options');
        });
    }

    public function down() {
        Schema::table('questions', function (Blueprint $table) {
            $table->dropColumn(['options', 'correct_answer']);
        });
    }
};
