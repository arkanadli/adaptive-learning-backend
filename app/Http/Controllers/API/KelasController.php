<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Kelas;

class KelasController extends Controller
{
    public function index() {
        return Kelas::all();
    }

    public function store(Request $request) {
        $validated = $request->validate(['name' => 'required|string']);
        $Kelas = Kelas::create($validated);
        return response()->json($Kelas, 201);
    }

    public function show($id) {
        return Kelas::findOrFail($id);
    }

    public function update(Request $request, $id) {
        $Kelas = Kelas::findOrFail($id);
        $validated = $request->validate(['name' => 'required|string']);
        $Kelas->update($validated);
        return response()->json($Kelas);
    }

    public function destroy($id) {
        Kelas::findOrFail($id)->delete();
        return response()->json(null, 204);
    }
}
