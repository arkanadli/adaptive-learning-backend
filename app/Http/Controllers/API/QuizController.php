<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

use App\Models\Quiz;
use App\Models\Question;
use App\Models\UserAnswer;
use App\Models\User;

class QuizController extends Controller
{

    public function startQuiz($quizId) {
        $quiz = Quiz::with(['questions', 'jadwal.kelas', 'jadwal.subject', 'jadwal.guru'])
                    ->findOrFail($quizId);

        $firstQuestion = $quiz->questions()->orderBy('difficulty_level')->first();

        return response()->json([
            'quiz' => $quiz,
            'currentQuestion' => $firstQuestion,
            'questionNumber' => 1,
            'totalQuestions' => $quiz->questions->count()
        ], 200);
    }

    public function submitAnswer(Request $request, $quizId)
    {
        $user =  $request->user();

        $validated = $request->validate([
            'question_id' => 'required|exists:questions,id',
            'selected_answer' => 'required'
        ]);

        $question = Question::findOrFail($validated['question_id']);

        $userAnswer = UserAnswer::firstOrNew([
            'user_id' => $user->id,
            'question_id' => $question->id
        ]);

        $userAnswer->selected_answer = $validated['selected_answer'];
        $userAnswer->is_correct = ($question->correct_answer === $validated['selected_answer']);
        $userAnswer->save();

        $nextQuestion = $this->getNextQuestion($user, $question);

        if ($nextQuestion) {
            return response()->json([
                'nextQuestion' => $nextQuestion
            ], 200);
        }

        return response()->json([
            'message' => 'Quiz completed'
        ], 200);
    }

    private function getNextQuestion(User $user, Question $currentQuestion)
    {
        $lastAnswer = $user->answers()
            ->where('question_id', $currentQuestion->id)
            ->first();

        $answeredIds = $user->answers()->pluck('question_id');

        if (!$lastAnswer) {
            return Question::where('quiz_id', $currentQuestion->quiz_id)
                ->where('difficulty_level', 1)
                ->whereNotIn('id', $answeredIds)
                ->first();
        }

        $difficultyOperator = $lastAnswer->is_correct ? '>' : '<';

        return Question::where('quiz_id', $currentQuestion->quiz_id)
            ->where('difficulty_level', $difficultyOperator, $currentQuestion->difficulty_level)
            ->whereNotIn('id', $answeredIds)
            ->orderBy('difficulty_level')
            ->first();
    }

    public function showResult($quizId) {
        $user = Auth::user();

        $correctAnswers = UserAnswer::where('user_id', $user->id)
            ->whereHas('question', fn($query) => $query->where('quiz_id', $quizId))
            ->where('is_correct', true)
            ->count();

        $totalQuestions = Quiz::withCount('questions')->findOrFail($quizId)->questions_count;

        return response()->json([
            'score' => $correctAnswers,
            'total' => $totalQuestions
        ], 200);
    }

    public function showQuestion($quizId, $questionId)
    {
        $quiz = Quiz::with('jadwal.kelas', 'jadwal.subject', 'jadwal.guru')->findOrFail($quizId);
        $question = Question::findOrFail($questionId);
        $questionNumber = $quiz->questions()->where('id', '<=', $questionId)->count();

        return response()->json([
            'quiz' => $quiz,
            'currentQuestion' => $question,
            'questionNumber' => $questionNumber,
            'totalQuestions' => $quiz->questions->count()
        ], 200);
    }

    public function index() {
        $quizzes = Quiz::with(['jadwal.kelas', 'jadwal.subject', 'jadwal.guru'])
                      ->withCount('questions')
                      ->get();

        return response()->json($quizzes, 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'jadwal_id' => 'required|exists:jadwals,id',
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'questions' => 'required|array|min:1',
            'questions.*.question_text' => 'required|string',
            'questions.*.options' => 'required|array|min:2',
            'questions.*.correct_answer' => 'required|string',
            'questions.*.difficulty_level' => 'required|integer|min:1'
        ]);

        $quiz = Quiz::create([
            'jadwal_id' => $validated['jadwal_id'],
            'title' => $validated['title'],
            'description' => $validated['description'] ?? null,
        ]);

        foreach ($validated['questions'] as $q) {
            $quiz->questions()->create($q);
        }

        return response()->json($quiz->load(['questions', 'jadwal.kelas', 'jadwal.subject', 'jadwal.guru']), 201);
    }

    public function show($id)
    {
        $quiz = Quiz::with(['questions', 'jadwal.kelas', 'jadwal.subject', 'jadwal.guru'])
                    ->findOrFail($id);
        return response()->json($quiz, 200);
    }

    public function update(Request $request, $id)
    {
        $quiz = Quiz::with('questions')->findOrFail($id);

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'questions' => 'nullable|array',
            'questions.*.id' => 'nullable|exists:questions,id',
            'questions.*.question_text' => 'required_with:questions|string',
            'questions.*.options' => 'required_with:questions|array|min:2',
            'questions.*.correct_answer' => 'required_with:questions|string',
            'questions.*.difficulty_level' => 'required_with:questions|integer|min:1'
        ]);

        $quiz->update([
            'title' => $validated['title'],
            'description' => $validated['description'] ?? null,
        ]);

        if (isset($validated['questions'])) {
            $existingIds = collect($validated['questions'])->pluck('id')->filter()->all();
            $quiz->questions()->whereNotIn('id', $existingIds)->delete();

            foreach ($validated['questions'] as $q) {
                if (!empty($q['id'])) {
                    $question = Question::findOrFail($q['id']);
                    $question->update($q);
                } else {
                    $quiz->questions()->create($q);
                }
            }
        }

        return response()->json($quiz->fresh(['questions', 'jadwal.kelas', 'jadwal.subject', 'jadwal.guru']), 200);
    }

    public function destroy($id)
    {
        $quiz = Quiz::findOrFail($id);
        $quiz->questions()->delete();
        $quiz->delete();

        return response()->json(['message' => 'Quiz and related questions deleted.'], 200);
    }

    public function quizByJadwal($id)
    {
        $quiz = Quiz::where('jadwal_id', $id)
            ->with(['questions', 'jadwal.kelas', 'jadwal.subject', 'jadwal.guru'])
            ->get();
        return response()->json($quiz, 200);
    }
}
