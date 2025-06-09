<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Models\Materi;

class MateriController extends Controller
{
    public function index() {
        return Materi::with('jadwal.kelas', 'jadwal.subject', 'jadwal.guru')->get();
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string',
            'description' => 'nullable|string',
            'difficulty_level' => 'required|integer',
            'jadwal_id' => 'required|exists:jadwals,id',
            'file' => 'nullable|file|max:10240',
        ]);

        $filePath = null;
        $fileName = null;

        if ($request->hasFile('file')) {
            $uploadedFile = $request->file('file');
            $fileName = time() . '_' . $uploadedFile->getClientOriginalName();
            $filePath = 'materi/' . $fileName;

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

        $materi = Materi::create([
            'title' => $request->title,
            'description' => $request->description,
            'difficulty_level' => $request->difficulty_level,
            'jadwal_id' => $request->jadwal_id,
            'file_path' => $filePath,
            'file_name' => $fileName,
        ]);

        return response()->json($materi, 201);
    }

    public function show($id) {
        return Materi::with('jadwal.kelas', 'jadwal.subject', 'jadwal.guru')->findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $materi = Materi::findOrFail($id);

        $request->validate([
            'title' => 'required|string',
            'description' => 'required|string',
            'difficulty_level' => 'required|integer',
            'file' => 'nullable|file|max:10240',
        ]);

        $filePath = $materi->file_path;
        $fileName = $materi->file_name;

        if ($request->hasFile('file')) {
            if ($filePath && Storage::disk('s3')->exists($filePath)) {
                Storage::disk('s3')->delete($filePath);
            }

            $uploadedFile = $request->file('file');
            $fileName = time() . '_' . $uploadedFile->getClientOriginalName();
            $filePath = 'materi/' . $fileName;

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

        $materi->update([
            'title' => $request->title,
            'description' => $request->description,
            'difficulty_level' => $request->difficulty_level,
            'file_path' => $filePath,
            'file_name' => $fileName,
        ]);

        $materi->load('jadwal.kelas', 'jadwal.subject', 'jadwal.guru');

        return response()->json($materi);
    }

    public function destroy($id) {
        $materi = Materi::findOrFail($id);

        if ($materi->file_path && Storage::disk('s3')->exists($materi->file_path)) {
            Storage::disk('s3')->delete($materi->file_path);
        }

        $materi->delete();

        return response()->json(['message' => 'Materi deleted successfully']);
    }

    public function materiByJadwal($id)
    {
        $materi = Materi::with(['jadwal.kelas', 'jadwal.subject', 'jadwal.guru'])
            ->where('jadwal_id', $id)
            ->get();
        return response()->json($materi, 200);
    }
}

