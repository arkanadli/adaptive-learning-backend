<?php

namespace App\Notifications;

use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Support\Facades\URL;

class ResetPasswordNotification extends Notification
{
    public $token;

    public function __construct($token)
    {
        $this->token = $token;
    }

    public function via($notifiable)
    {
        return ['mail'];
    }

    public function toMail($notifiable)
    {
        // Ubah ke URL frontend
        $frontendUrl = env('FRONTEND_URL', 'http://localhost:5173') . '/reset-password'
            . '?token=' . $this->token
            . '&email=' . urlencode($notifiable->getEmailForPasswordReset());

        return (new MailMessage)
            ->subject('Reset Password')
            ->line('Klik tombol di bawah untuk mereset password Anda:')
            ->action('Reset Password', $frontendUrl)
            ->line('Jika Anda tidak meminta reset, abaikan email ini.');
    }
}
