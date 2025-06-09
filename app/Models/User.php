<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Laravel\Sanctum\HasApiTokens;

use App\Models\UserAnswer;
use App\Models\Absensi;
use App\Models\Role;
use App\Models\Kelas;
use App\Models\Jadwal;

use App\Notifications\ResetPasswordNotification;

/**
 * @property-read \Illuminate\Database\Eloquent\Collection<UserAnswer> $answers
 */
class User extends Authenticatable
{

    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
        'role_id',
        'profile_name',
        'profile_path',
        'gender',
        'tanggal_lahir',
        'tahun_masuk',
        'address',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function role() {
        return $this->belongsTo(Role::class);
    }

    public function kelas() {
        return $this->belongsTo(Kelas::class);
    }

    public function answers() {
        return $this->hasMany(UserAnswer::class);
    }

    public function absensi() {
        return $this->hasMany(Absensi::class);
    }

    public function jadwalUser() {
        return $this->hasMany(JadwalUser::class);
    }

    public function sendPasswordResetNotification($token)
    {
        $this->notify(new ResetPasswordNotification($token));
    }
}
