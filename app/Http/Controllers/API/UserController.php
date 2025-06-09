<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    public function index()
    {
        return response()->json(User::with(['role'])->get(), 200);
    }

    public function store(Request $request)
    {

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
            'role_id' => 'required|exists:roles,id',
            'profile' => 'nullable|file|max:10240',
            'gender' => 'nullable|in:L,P',
            'tanggal_lahir' => 'nullable|date_format:Y-m-d',
            'tahun_masuk' => 'nullable|date_format:Y',
            'address' => 'nullable|string',
        ]);

        $filePath = null;
        $fileName = null;

        if ($request->hasFile('profile')) {
            $uploadedFile = $request->file('file');
            $fileName = time() . '_' . $uploadedFile->getClientOriginalName();
            $filePath = 'profile/' . $fileName;

            try {
                $stream = fopen($uploadedFile->getPathname(), 'r');

                $result = Storage::disk('s3')->put($filePath, $stream);

                fclose($stream);

                if (!$result) {
                    return response()->json(['error' => 'Gagal menyimpan ke S3'], 500);
                }

                Storage::disk('s3')->setVisibility($filePath, 'public');
            } catch (\Exception $e) {
                return response()->json([
                    'error' => 'Exception saat upload ke S3',
                    'message' => $e->getMessage(),
                    'trace' => $e->getTraceAsString(),
                ], 500);
            }
        }

        $user = User::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
            'role_id' => $validated['role_id'],
            'profile_name' => $fileName,
            'profile_path' => $filePath,
            'gender' => $validated['gender'] ?? null,
            'tanggal_lahir' => $validated['tanggal_lahir'] ?? null,
            'tahun_masuk' => $validated['tahun_masuk'] ?? null,
            'address' => $validated['address'] ?? null,
        ]);

        $user->load('role');

        return response()->json($user, 201);
    }

    public function show($id)
    {
        $user = User::with('role')->findOrFail($id);
        return response()->json($user, 200);
    }

    public function update(Request $request, $id)
    {
        $user = User::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'email' => 'sometimes|string|email|max:255|unique:users,email,' . $user->id,
            'password' => 'sometimes|string|min:6|confirmed',
            'role_id' => 'sometimes|exists:roles,id',
            'profile' => 'nullable|file|max:10240',
            'gender' => 'nullable|in:L,P',
            'tanggal_lahir' => 'nullable|date_format:Y-m-d',
            'tahun_masuk' => 'nullable|date_format:Y',
            'address' => 'nullable|string',
        ]);

        if (isset($validated['name'])) {
            $user->name = $validated['name'];
        }

        if (isset($validated['email'])) {
            $user->email = $validated['email'];
        }

        if (isset($validated['password'])) {
            $user->password = Hash::make($validated['password']);
        }

        if (isset($validated['role_id'])) {
            $user->role_id = $validated['role_id'];
        }

        // Upload baru & hapus file lama jika ada
        if ($request->hasFile('profile')) {
            $uploadedFile = $request->file('profile');
            $fileName = time() . '_' . $uploadedFile->getClientOriginalName();
            $filePath = 'profile/' . $fileName;

            try {
            // Delete file lama jika ada
                if ($user->profile_path && Storage::disk('s3')->exists($user->profile_path)) {
                    Storage::disk('s3')->delete($user->profile_path);
                }

                $stream = fopen($uploadedFile->getPathname(), 'r');
                $result = Storage::disk('s3')->put($filePath, $stream);
                fclose($stream);

                if (!$result) {
                    return response()->json(['error' => 'Gagal menyimpan ke S3'], 500);
                }

                Storage::disk('s3')->setVisibility($filePath, 'public');

                $user->profile_name = $fileName;
                $user->profile_path = $filePath;
            } catch (\Exception $e) {
                return response()->json([
                    'error' => 'Exception saat upload ke S3',
                    'message' => $e->getMessage(),
                    'trace' => $e->getTraceAsString(),
                ], 500);
            }
        }

        // Update optional biodata
        if (array_key_exists('gender', $validated)) {
            $user->gender = $validated['gender'];
        }

        if (array_key_exists('tanggal_lahir', $validated)) {
            $user->tanggal_lahir = $validated['tanggal_lahir'];
        }

        if (array_key_exists('tahun_masuk', $validated)) {
            $user->tahun_masuk = $validated['tahun_masuk'];
        }

        if (array_key_exists('address', $validated)) {
            $user->address = $validated['address'];
        }

        $user->save();
        $user->load('role');

        return response()->json($user, 200);
    }

    public function destroy($id)
    {
        $user = User::findOrFail($id);
        $user->delete();

        return response()->json(['message' => 'User deleted'], 200);
    }

    public function indexGuru()
    {
        $gurus = User::with('role')->where('role_id', 2)->get();
        return response()->json($gurus, 200);
    }

    public function indexSiswa()
    {
        $siswa = User::with('role')->where('role_id', 1)->get();
        return response()->json($siswa, 200);
    }

    public function updateProfile(Request $request)
    {
        $user = $request->user();

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'email' => 'sometimes|email|max:255|unique:users,email,' . $user->id,
            'password' => 'nullable|string|min:6|confirmed',
        ]);

        if (isset($validated['name'])) {
            $user->name = $validated['name'];
        }

        if (isset($validated['email'])) {
            $user->email = $validated['email'];
        }

        if (!empty($validated['password'])) {
            $user->password = Hash::make($validated['password']);
        }

        $user->save();

        $user->load('role');

        return response()->json([
            'message' => 'Profile updated successfully',
            'user' => $user,
        ], 200);
    }

    public function updatePassword(Request $request)
    {
        $user = $request->user();

        $request->validate([
            'current_password' => 'required',
            'password' => 'required|string|min:6|confirmed',
        ]);

        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json(['message' => 'Password saat ini salah'], 400);
        }

        $user->password = Hash::make($request->password);
        $user->save();
        $user->load('role');

        return response()->json(['message' => 'Password berhasil diperbarui']);
    }

    public function getUsersCount()
    {
        $totalUsers  = User::count();
        $totalAdmin  = User::whereHas('role', fn($q) => $q->where('name', 'admin'))->count();
        $totalGuru   = User::whereHas('role', fn($q) => $q->where('name', 'guru'))->count();
        $totalSiswa  = User::whereHas('role', fn($q) => $q->where('name', 'siswa'))->count();

        return response()->json([
            'totalUsers' => $totalUsers,
            'totalAdmin' => $totalAdmin,
            'totalGuru'  => $totalGuru,
            'totalSiswa' => $totalSiswa,
        ]);
    }

    public function showAll($id)
    {
        $user = User::with(['role', 'answers.question.quiz', 'jadwalUser.jadwal.kelas', 'jadwalUser.jadwal.subject', 'jadwalUser.jadwal.guru'])
            ->findOrFail($id);
        return response()->json($user, 200);
    }

}
