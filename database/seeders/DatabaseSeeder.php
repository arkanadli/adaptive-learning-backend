<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Role;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        Role::create([
            'id' => 1,
            'name' => 'SISWA',
        ]);

        Role::create([
            'id' => 2,
            'name' => 'GURU',
        ]);

        Role::create([
            'id' => 3,
            'name' => 'ADMIN',
        ]);

        User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'),
            'role_id' => 1
        ]);
    }
}
