<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

use App\Models\UserAnswer;

class UserAnswerController extends Controller
{
    public function index() {
        return UserAnswer::with('user', 'question')->get();
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'question_id' => 'required|exists:questions,id',
            'selected_answer' => 'required|string',
            'is_correct' => 'required|tinyint',
            'attempt_number' => 'required|integer',
        ]);
        $UserAnswer = UserAnswer::create($validated);
        return response()->json($UserAnswer, 201);
    }

    public function show($id) {
        return UserAnswer::with('user', 'question')->findOrFail($id)->get();
    }

    public function update(Request $request, $id) {
        $UserAnswer = UserAnswer::findOrFail($id);
        $validated = $request->validate([
            'selected_answer' => 'required|string',
            'is_correct' => 'required|tinyint',
        ]);
        $UserAnswer->update($validated);
        return response()->json($UserAnswer);
    }

    public function destroy($id) {
        UserAnswer::findOrFail($id)->delete();
        return response()->json(null, 204);
    }

    public function submitAnswers(Request $request)
    {
        $validated = Validator::make($request->all(), [
            '*.user_id' => 'required|exists:users,id',
            '*.question_id' => 'required|exists:questions,id',
            '*.selected_answer' => 'required|string',
            '*.is_correct' => 'required|boolean',
            '*.attempt_number' => 'required|integer',
        ]);

        if ($validated->fails()) {
            return response()->json(['errors' => $validated->errors()], 422);
        }

        $answers = $request->all();

        UserAnswer::insert($answers);

        return response()->json(['message' => 'Jawaban berhasil disimpan'], 201);
    }

    public function summary(Request $req) {
        $quizId = $req->quiz_id;
        $results = UserAnswer::selectRaw('user_id, COUNT(*) as total, SUM(is_correct) as correct')
            ->whereHas('question', fn($q) => $q->where('quiz_id', $quizId))
            ->groupBy('user_id')
            ->with('user:id,name')
            ->get()
            ->map(fn($r) => [
                'user_id'=> $r->user_id,
                'name'=> $r->user->name,
                'score'=> round($r->correct / $r->total * 100),
            ]);
        return response()->json($results);
    }

    public function getByQuiz(Request $request, $quizId)
    {
        $query = UserAnswer::with(['user', 'question'])
            ->whereHas('question', function ($q) use ($quizId) {
                $q->where('quiz_id', $quizId);
            });

        if ($request->has('user_id')) {
            $query->where('user_id', $request->user_id);
        }

        $answers = $query->get();

        return response()->json($answers);
    }
}
