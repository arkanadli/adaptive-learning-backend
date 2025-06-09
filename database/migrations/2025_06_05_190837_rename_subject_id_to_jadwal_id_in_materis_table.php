<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up()
    {
        Schema::table('materis', function (Blueprint $table) {
            $table->renameColumn('subject_id', 'jadwal_id');
        });
    }

    public function down()
    {
        Schema::table('materis', function (Blueprint $table) {
            $table->renameColumn('jadwal_id', 'subject_id');
        });
    }

};
