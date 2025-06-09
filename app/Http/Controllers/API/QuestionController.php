<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Question;

class QuestionController extends Controller
{
    public function index()
    {
        $questions = Question::with('quiz')->get();
        return response()->json($questions, 200);
    }

    public function show($id)
    {
        $question = Question::with('quiz')->findOrFail($id);
        return response()->json($question, 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'quiz_id' => 'required|exists:quizzes,id',
            'question_text' => 'required|string',
            'options' => 'required|array|min:2',
            'correct_answer' => 'required|string',
            'difficulty_level' => 'required|integer|min:1',
        ]);

        $question = Question::create($validated);

        $question->load('quiz');

        return response()->json($question, 201);
    }

    public function update(Request $request, $id)
    {
        $question = Question::findOrFail($id);

        $validated = $request->validate([
            'question_text' => 'required|string',
            'options' => 'required|array|min:2',
            'correct_answer' => 'required|string',
            'difficulty_level' => 'required|integer|min:1',
        ]);

        $question->update($validated);

        $question->load('quiz');

        return response()->json($question, 200);
    }

    public function destroy($id)
    {
        $question = Question::findOrFail($id);
        $question->delete();

        return response()->json(['message' => 'Question deleted successfully'], 200);
    }
}
