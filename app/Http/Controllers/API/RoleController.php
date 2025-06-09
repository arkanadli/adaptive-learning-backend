<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Role;

class RoleController extends Controller
{
    public function index() {
        return Role::all();
    }

    public function store(Request $request) {
        $validated = $request->validate(['name' => 'required|string']);
        $Role = Role::create($validated);
        return response()->json($Role, 201);
    }

    public function show($id) {
        return Role::findOrFail($id);
    }

    public function update(Request $request, $id) {
        $Role = Role::findOrFail($id);
        $validated = $request->validate(['name' => 'required|string']);
        $Role->update($validated);
        return response()->json($Role);
    }

    public function destroy($id) {
        Role::findOrFail($id)->delete();
        return response()->json(null, 204);
    }
}
