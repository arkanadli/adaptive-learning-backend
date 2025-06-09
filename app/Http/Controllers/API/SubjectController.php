<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Subject;

class SubjectController extends Controller
{
    public function index() {
        return Subject::all();
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'name' => 'required|string',
            'code' => 'required|string',
            'singkatan' => 'required|string',
        ]);
        $Subject = Subject::create($validated);
        return response()->json($Subject, 201);
    }

    public function show($id) {
        return Subject::findOrFail($id);
    }

    public function update(Request $request, $id) {
        $Subject = Subject::findOrFail($id);
        $validated = $request->validate([
            'name' => 'required|string',
            'code' => 'required|string',
            'singkatan' => 'required|string',
        ]);
        $Subject->update($validated);
        return response()->json($Subject);
    }

    public function destroy($id) {
        Subject::findOrFail($id)->delete();
        return response()->json(null, 204);
    }
}
