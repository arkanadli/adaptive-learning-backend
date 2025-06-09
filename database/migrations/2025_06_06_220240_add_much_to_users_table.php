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
        Schema::table('users', function (Blueprint $table) {

            $table->string('profile_name')->nullable()->after('role_id');
            $table->string('profile_path')->nullable()->after('profile_name');

            $table->enum('gender', ['L', 'P'])->nullable()->after('profile_path');
            $table->date('tanggal_lahir')->nullable()->after('gender');
            $table->year('tahun_masuk')->nullable()->after('tanggal_lahir');
            $table->string('address')->nullable()->after('tahun_masuk');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn([
                'profile_name',
                'profile_path',
                'gender',
                'tanggal_lahir',
                'tahun_masuk',
                'address',
            ]);
        });
    }
};
