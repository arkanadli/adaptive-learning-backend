<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('user_answers', function (Blueprint $table) {
            // Drop foreign key constraint dulu
            $table->dropForeign(['user_id']);
            $table->dropForeign(['question_id']);

            // Tambahkan ulang dengan onDelete('cascade')
            $table->foreign('user_id')
                  ->references('id')->on('users')
                  ->onDelete('cascade');

            $table->foreign('question_id')
                  ->references('id')->on('questions')
                  ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('user_answers', function (Blueprint $table) {
            $table->dropForeign(['user_id']);
            $table->dropForeign(['question_id']);

            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('question_id')->references('id')->on('questions');
        });
    }
};
