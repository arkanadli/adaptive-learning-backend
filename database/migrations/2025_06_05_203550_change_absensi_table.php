<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('absensis', function (Blueprint $table) {

            if (Schema::hasColumn('absensis', 'user_id')) {
                $table->dropForeign(['user_id']);
                $table->dropColumn('user_id');
            }
            if (Schema::hasColumn('absensis', 'jadwal_id')) {
                $table->dropForeign(['jadwal_id']);
                $table->dropColumn('jadwal_id');
            }

            $table->unsignedBigInteger('jadwal_user_id')->after('id');
            $table->foreign('jadwal_user_id')
                  ->references('id')
                  ->on('jadwal_users')
                  ->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::table('absensis', function (Blueprint $table) {
            if (Schema::hasColumn('absensis', 'jadwal_user_id')) {
                $table->dropForeign(['jadwal_user_id']);
                $table->dropColumn('jadwal_user_id');
            }
            $table->unsignedBigInteger('user_id')->after('id');
            $table->foreign('user_id')
                  ->references('id')
                  ->on('users')
                  ->onDelete('cascade');

            $table->unsignedBigInteger('jadwal_id')->after('user_id');
            $table->foreign('jadwal_id')
                  ->references('id')
                  ->on('jadwals')
                  ->onDelete('cascade');
        });
    }
};
