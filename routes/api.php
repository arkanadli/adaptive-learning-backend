<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\{
    AuthController, UserController, RoleController, KelasController,
    SubjectController, MateriController, QuizController,
    QuestionController, UserAnswerController, JadwalController,
    AbsensiController, DashboardController, JadwalUserController
};

use App\Http\Controllers\Auth\ForgotPasswordController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::post('/forgot-password', [ForgotPasswordController::class, 'sendResetLinkEmail']);
Route::post('/reset-password', [ForgotPasswordController::class, 'resetPassword']);

Route::middleware('auth:sanctum')->group(function () {
    // AUTH
    Route::get('/user', [AuthController::class, 'user']);
    Route::post('/logout', [AuthController::class, 'logout']);

    //DASHBOARD
    Route::get('/users/count', [DashboardController::class, 'getUsersCount']);
    Route::get('/kelas/count', [DashboardController::class, 'getKelasCount']);
    Route::get('/subjek/count', [DashboardController::class, 'getSubjekCount']);
    Route::get('/absensi/summary-today', [DashboardController::class, 'getAttendanceSummary']);
    Route::get('/roles/distribution', [DashboardController::class, 'getRoleDistribution']);
    Route::get('/jadwal/upcoming', [DashboardController::class, 'getUpcomingSchedule']);
    Route::get('/absensi/trend-weekly', [DashboardController::class, 'getAttendanceTrend']);

    Route::get('/quiz/{quiz}', [QuizController::class, 'startQuiz']);
    Route::post('/quiz/{quiz}/submit', [QuizController::class, 'submitAnswer']);
    Route::get('/quiz/{quiz}/result', [QuizController::class, 'showResult']);
    Route::get('/quiz/{quiz}/question/{question}', [QuizController::class, 'showQuestion']);

    // ROLES
    Route::apiResource('roles', RoleController::class);

    // USER
    Route::get('/guru', [UserController::class, 'indexGuru']);
    Route::get('/guru/kelas/{id}', [JadwalController::class, 'getJadwalGuru']);
    Route::get('/siswa/kelas/{id}', [JadwalUserController::class, 'getJadwalSiswa']);
    Route::get('/siswa', [UserController::class, 'indexSiswa']);
    Route::put('/profile', [UserController::class, 'updateProfile']);
    Route::put('/update-password', [UserController::class, 'updatePassword']);
    Route::get('/users/jadwal/{id}', [JadwalUserController::class, 'userByJadwal']);
    Route::get('/users/all/{id}', [UserController::class, 'showAll']);
    Route::apiResource('users', UserController::class);

    // KELAS
    Route::apiResource('kelas', KelasController::class);

    // SUBJEK
    Route::apiResource('subjects', SubjectController::class);

    // MATERI
    Route::get('/materis/jadwal/{id}', [MateriController::class, 'materiByJadwal']);
    Route::apiResource('materis', MateriController::class);

    // QUIZ
    Route::get('/quizzes/{quiz}/answers', [UserAnswerController::class, 'getByQuiz']);
    Route::get('/quizzes/jadwal/{id}', [QuizController::class, 'quizByJadwal']);
    Route::apiResource('quizzes', QuizController::class);

    // QUESTION
    Route::apiResource('questions', QuestionController::class);

    // USER ANSWER
    Route::post('/user-answers/batch', [UserAnswerController::class, 'submitAnswers']);
    Route::get('/user-answers/summary', [UserAnswerController::class, 'summary']);
    Route::apiResource('user-answers', UserAnswerController::class);

    // JADWAL
    Route::apiResource('jadwals', JadwalController::class);

    // ABSENSI
    Route::get('/absensis/jadwal/{id}', [AbsensiController::class, 'absensiByJadwal']);
    Route::apiResource('absensis', AbsensiController::class);

    // ENROLLMENT/JADWAL-USER
    Route::get('/enrollment/get-id', [JadwalUserController::class, 'getIdByJadwalUser']);
    Route::apiResource('enrollment', JadwalUserController::class);
});

