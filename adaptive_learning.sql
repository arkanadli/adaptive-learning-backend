-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 09, 2025 at 07:17 PM
-- Server version: 8.0.30
-- PHP Version: 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `adaptive_learning`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensis`
--

CREATE TABLE `absensis` (
  `id` bigint UNSIGNED NOT NULL,
  `jadwal_user_id` bigint UNSIGNED NOT NULL,
  `tanggal` datetime NOT NULL,
  `status` enum('hadir','izin','sakit','alpa') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `absensis`
--

INSERT INTO `absensis` (`id`, `jadwal_user_id`, `tanggal`, `status`, `created_at`, `updated_at`) VALUES
(7, 1, '2025-06-02 09:15:00', 'hadir', '2025-06-05 15:00:55', '2025-06-08 18:49:01'),
(8, 2, '2025-06-02 09:10:00', 'hadir', '2025-06-08 17:37:10', '2025-06-08 20:12:27');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jadwals`
--

CREATE TABLE `jadwals` (
  `id` bigint UNSIGNED NOT NULL,
  `kelas_id` bigint UNSIGNED NOT NULL,
  `subject_id` bigint UNSIGNED NOT NULL,
  `guru_id` bigint UNSIGNED NOT NULL,
  `hari` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jadwals`
--

INSERT INTO `jadwals` (`id`, `kelas_id`, `subject_id`, `guru_id`, `hari`, `jam_mulai`, `jam_selesai`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 11, 'Senin', '07:00:00', '09:00:00', '2025-06-03 12:19:26', '2025-06-08 21:07:14'),
(2, 1, 2, 2, 'Jumat', '08:00:00', '11:00:00', '2025-06-04 20:52:21', '2025-06-04 20:52:21'),
(3, 2, 1, 11, 'Senin', '10:00:00', '12:00:00', '2025-06-06 10:30:28', '2025-06-08 21:06:55');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_users`
--

CREATE TABLE `jadwal_users` (
  `id` bigint UNSIGNED NOT NULL,
  `jadwal_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `difficulty_level` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jadwal_users`
--

INSERT INTO `jadwal_users` (`id`, `jadwal_id`, `user_id`, `difficulty_level`, `created_at`, `updated_at`) VALUES
(1, 1, 6, 3, '2025-06-05 13:42:10', '2025-06-09 08:03:46'),
(2, 1, 9, 1, '2025-06-05 14:55:34', '2025-06-09 08:59:01'),
(3, 2, 6, NULL, '2025-06-05 15:57:59', '2025-06-05 15:57:59'),
(4, 2, 9, NULL, '2025-06-05 15:58:04', '2025-06-05 15:58:04'),
(5, 1, 10, NULL, '2025-06-05 15:58:09', '2025-06-08 21:03:11');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'AA', '2025-06-02 22:19:05', '2025-06-02 22:19:17'),
(2, 'BB', '2025-06-02 22:23:11', '2025-06-02 22:23:11'),
(3, 'CC', '2025-06-02 22:23:15', '2025-06-02 22:23:15'),
(4, 'DD', '2025-06-04 11:12:14', '2025-06-04 11:12:14'),
(5, 'EE', '2025-06-04 11:12:18', '2025-06-04 11:12:18');

-- --------------------------------------------------------

--
-- Table structure for table `materis`
--

CREATE TABLE `materis` (
  `id` bigint UNSIGNED NOT NULL,
  `jadwal_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `difficulty_level` int NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `materis`
--

INSERT INTO `materis` (`id`, `jadwal_id`, `title`, `description`, `difficulty_level`, `file_name`, `file_path`, `created_at`, `updated_at`) VALUES
(8, 1, 'Matematika Level 1: Pengenalan Bilangan Bulat dan Operasi Dasar', 'Materi ini memperkenalkan konsep dasar bilangan bulat, yang merupakan bilangan tanpa pecahan atau desimal. Bilangan bulat terdiri dari bilangan positif (contoh: 1, 2, 3, ...), bilangan negatif (contoh: -3, -2, -1), dan nol (0). Konsep ini juga dijelaskan melalui representasi pada garis bilangan, di mana nilai semakin besar ketika bergerak ke kanan dan semakin kecil ketika bergerak ke kiri. Materi ini selanjutnya membahas operasi dasar penjumlahan dan pengurangan bilangan bulat. Untuk penjumlahan, ada aturan untuk tanda yang sama (jumlahkan angkanya, hasilnya mengikuti tanda tersebut, contoh: 3+5=8, (−3)+(−5)=−8)  dan tanda yang berbeda (kurangkan angka yang lebih besar dengan yang lebih kecil, hasilnya mengikuti tanda angka yang lebih besar, contoh: 5+(−3)=2, (−5)+3=−2). Pengurangan bilangan bulat dijelaskan sebagai penjumlahan dengan lawan dari bilangan pengurangnya (contoh: 5−3=5+(−3)=2, 5−(−3)=5+3=8).', 1, '1749220305_MATEMATIKA LEVEL 1.pdf', 'materi/1749220305_MATEMATIKA LEVEL 1.pdf', '2025-06-06 07:44:23', '2025-06-07 05:23:18'),
(10, 1, 'Matematika Level 2: Perkalian, Pembagian, dan Operasi Campuran Bilangan Bulat', 'Materi ini melanjutkan pembahasan bilangan bulat dengan fokus pada operasi perkalian dan pembagian, serta operasi hitung campuran. Aturan tanda untuk perkalian dan pembagian dijelaskan secara rinci: positif dikali/dibagi positif hasilnya positif, negatif dikali/dibagi negatif hasilnya positif, positif dikali/dibagi negatif hasilnya negatif, dan negatif dikali/dibagi positif hasilnya negatif. Contoh-contoh diberikan untuk memperjelas aturan ini, seperti 3×4=12 dan (−3)×(−4)=12 untuk perkalian, serta 12÷3=4 dan (−12)÷(−3)=4 untuk pembagian. Bagian selanjutnya membahas operasi hitung campuran bilangan bulat menggunakan urutan PEMDAS/BODMAS (Parentheses/Kurung, Exponents/Pangkat, Multiplication/Perkalian dan Division/Pembagian dari kiri ke kanan, Addition/Penjumlahan dan Subtraction/Pengurangan dari kiri ke kanan). Sebuah contoh langkah demi langkah disajikan untuk menunjukkan penerapan aturan ini: 10+5×2−8÷4=18.', 2, '1749221572_MATEMATIKA LEVEL 2.pdf', 'materi/1749221572_MATEMATIKA LEVEL 2.pdf', '2025-06-06 14:52:53', '2025-06-07 05:23:40'),
(11, 1, 'Matematika Level 3: Bilangan Pecahan dan Himpunan Dasar', 'Materi ini memperkenalkan bilangan pecahan sebagai cara menyatakan bagian dari keseluruhan, dengan pembilang sebagai angka di atas yang menunjukkan bagian yang dimiliki dan penyebut sebagai angka di bawah yang menunjukkan total bagian. Contoh pecahan seperti  1/2 dan  3/4 juga diberikan. Operasi penjumlahan dan pengurangan pecahan dibahas, dengan aturan berbeda untuk penyebut yang sama (langsung jumlahkan atau kurangkan pembilang) dan penyebut yang berbeda (samakan penyebut dengan mencari KPK terlebih dahulu). Selanjutnya, materi ini menjelaskan perkalian pecahan (kalikan pembilang dengan pembilang, penyebut dengan penyebut) dan pembagian pecahan (ubah operasi pembagian menjadi perkalian dengan membalik pecahan kedua, lalu sederhanakan jika memungkinkan). Bagian kedua dari materi ini adalah pengantar Himpunan, yang didefinisikan sebagai kumpulan benda atau objek yang didefinisikan dengan jelas. Anggota himpunan dilambangkan dengan ∈, sementara bukan anggota dilambangkan dengan ∈. Tiga cara menyatakan himpunan dijelaskan: mendeskripsikan sifat anggota (contoh: A= {bilangan asli kurang dari 5}), mendaftar anggota (contoh: A={1,2,3,4}) , dan notasi pembentuk himpunan (contoh: A={x∣x<5,x∈bilangan asli}).', 3, '1749221634_MATEMATIKA LEVEL 3.pdf', 'materi/1749221634_MATEMATIKA LEVEL 3.pdf', '2025-06-06 14:53:56', '2025-06-07 05:24:02');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_05_22_145052_create_quizzes_table', 1),
(5, '2025_05_22_145301_create_question_table', 1),
(6, '2025_05_22_145438_create_user_answers_table', 1),
(7, '2025_05_22_162336_add_options_and_correct_answer_to_questions_table', 1),
(8, '2025_05_22_162518_add_selected_answers', 1),
(9, '2025_05_27_165618_create_personal_access_tokens_table', 1),
(10, '2025_05_29_165126_create_roles_table', 1),
(11, '2025_05_29_165322_add_role_id_to_users_table', 1),
(12, '2025_05_29_165429_create_kelas_table', 1),
(13, '2025_05_29_165556_create_subjects_table', 1),
(14, '2025_05_29_165639_create_materis_table', 1),
(15, '2025_05_29_165726_create_jadwals_table', 1),
(16, '2025_05_29_165834_create_absensis_table', 1),
(17, '2025_05_29_184910_update_user_answers_foreign_keys', 2),
(18, '2025_06_04_032935_change_tanggal_to_datetime_in_absensis_table', 3),
(19, '2025_06_05_173703_add_singkatan_in_subjek_table', 4),
(20, '2025_06_05_190837_rename_subject_id_to_jadwal_id_in_materis_table', 5),
(21, '2025_06_05_191253_remove_user_id_from_materis_table', 6),
(22, '2025_06_05_192925_create_jadwal_user_table', 7),
(23, '2025_06_05_193125_add_jadwal_id_to_quizzes_table', 8),
(24, '2025_06_05_203550_change_absensi_table', 9),
(25, '2025_06_05_233849_add_diff_to_materis_table', 10),
(26, '2025_06_06_003552_add_diff_to_jadwal_users_table', 11),
(27, '2025_06_06_075120_add_file_name_to_materis_table', 12),
(28, '2025_06_06_220240_add_much_to_users_table', 13),
(29, '2025_06_08_190652_add_attempt_number_to_user_answers_table', 14);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('fadlanzikri11@gmail.com', '$2y$12$TaD6xs2WrAC6hYdUPfxYme9HuV0P/ytAADAl8EmRh4SKjAlVnWJ0C', '2025-06-02 23:22:52'),
('john@example.com', '$2y$12$IfJUIYPmJ6d5yNtI0vPgU.vAVgRV6aUY0voVA7Glp.lhluKfgRef2', '2025-05-30 03:04:29');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', 'd8877bb2eca6956e183a532c63ac0c5c09b9572b899f6bcc01ca6f725ff92e50', '[\"*\"]', '2025-06-09 10:20:09', NULL, '2025-05-29 11:08:40', '2025-06-09 10:20:09'),
(121, 'App\\Models\\User', 11, 'auth_token', '6699889930b7edc8010bc91d8c7980426f3db08628a85cf3fb18ec8f6bc3aa2d', '[\"*\"]', '2025-06-06 15:00:29', NULL, '2025-06-06 13:14:16', '2025-06-06 15:00:29'),
(130, 'App\\Models\\User', 11, 'auth_token', '8c80194b19b906f7f640a79681863c363bc393611b0dcc9ea20b1d795fdfc30b', '[\"*\"]', '2025-06-08 12:01:08', NULL, '2025-06-06 17:18:03', '2025-06-08 12:01:08'),
(131, 'App\\Models\\User', 9, 'auth_token', '612dce4cbbdf898152b596dc54356d7ff075b03ba06776f2bba4ce79b22f84cf', '[\"*\"]', '2025-06-08 20:24:21', NULL, '2025-06-08 11:56:37', '2025-06-08 20:24:21'),
(133, 'App\\Models\\User', 7, 'auth_token', '71ea668e39fe9511f9d19adad78ade66074d7f5e809a5e53a2d1c7d82f13d2d8', '[\"*\"]', '2025-06-08 19:16:33', NULL, '2025-06-08 17:14:36', '2025-06-08 19:16:33'),
(138, 'App\\Models\\User', 9, 'auth_token', '9e366ead4c6f97386fb5c5eeb4b810034b2e9f24ec0eed91e994cf7aecda2d7e', '[\"*\"]', '2025-06-09 10:54:35', NULL, '2025-06-09 08:03:09', '2025-06-09 10:54:35'),
(140, 'App\\Models\\User', 6, 'auth_token', '39ce46d09e5f4142bd5662632683effad9d8e591e563c4e83bd5678b05563924', '[\"*\"]', '2025-06-09 10:54:35', NULL, '2025-06-09 10:13:22', '2025-06-09 10:54:35'),
(145, 'App\\Models\\User', 11, 'auth_token', '3ad5490bb5e58a98c74382b0caf3edc185afdca036aaba3de7cb2f1cf70bfc03', '[\"*\"]', '2025-06-09 11:09:08', NULL, '2025-06-09 11:04:15', '2025-06-09 11:09:08');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` bigint UNSIGNED NOT NULL,
  `quiz_id` bigint UNSIGNED NOT NULL,
  `question_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` json NOT NULL,
  `correct_answer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `difficulty_level` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `quiz_id`, `question_text`, `options`, `correct_answer`, `difficulty_level`, `created_at`, `updated_at`) VALUES
(1, 1, 'Hasil dari 5+(−7) adalah ...', '{\"A\": \"12\", \"B\": \"2\", \"C\": \"-2\", \"D\": \"12\"}', 'C', 1, '2025-06-06 19:01:26', '2025-06-08 16:25:25'),
(2, 1, 'Suhu di Puncak Jayawijaya adalah −4°C. Jika suhu naik 6°C, suhu sekarang adalah ...', '{\"A\": \"10°C\", \"B\": \"2°C\", \"C\": \"-2°C\", \"D\": \"-10°C\"}', 'B', 1, '2025-06-06 19:01:26', '2025-06-08 16:25:25'),
(3, 1, 'Nilai dari (−9)−(−4) adalah ...', '{\"A\": \"-13\", \"B\": \"-5\", \"C\": \"5\", \"D\": \"13\"}', 'B', 1, '2025-06-06 19:01:26', '2025-06-08 16:25:25'),
(4, 1, 'Urutan bilangan bulat dari yang terkecil ke terbesar adalah ...', '{\"A\": \"−3, 0, 2, −5, 1\", \"B\": \"−5, −3, 0, 1, 2\", \"C\": \"2, 1, 0, −3, −5\", \"D\": \"0, 1, −3, 2, −5\"}', 'B', 1, '2025-06-06 19:01:26', '2025-06-08 16:25:25'),
(5, 1, 'Di antara bilangan berikut, manakah yang paling kecil?', '{\"A\": \"-10\", \"B\": \"-5\", \"C\": \"0\", \"D\": \"3\"}', 'A', 1, '2025-06-06 19:01:26', '2025-06-08 16:25:25'),
(7, 3, 'Hasil dari ( −6 ) × 7 adalah ...', '{\"A\": \"42\", \"B\": \"−42\", \"C\": \"13\", \"D\": \"−1\"}', 'B', 2, '2025-06-07 06:37:28', '2025-06-07 06:37:28'),
(8, 3, 'Jika 24 ÷ ( −3 ) maka hasilnya adalah ...', '{\"A\": \"8\", \"B\": \"-8\", \"C\": \"-21\", \"D\": \"21\"}', 'B', 2, '2025-06-07 06:37:28', '2025-06-07 06:37:28'),
(9, 3, 'Nilai dari ( −5 ) × ( −4 ) adalah ...', '{\"A\": \"−20\", \"B\": \"-9\", \"C\": \"9\", \"D\": \"20\"}', 'D', 2, '2025-06-07 06:37:28', '2025-06-07 06:37:28'),
(10, 3, 'Hasil dari 12 + ( −3 ) × 4 adalah ...', '{\"A\": \"0\", \"B\": \"−24\", \"C\": \"36\", \"D\": \"24\"}', 'A', 2, '2025-06-07 06:37:28', '2025-06-07 06:37:28'),
(11, 3, 'Nilai dari 20 ÷ 5 −2 × 3 adalah ...', '{\"A\": \"−2\", \"B\": \"2\", \"C\": \"4\", \"D\": \"14\"}', 'A', 2, '2025-06-07 06:37:28', '2025-06-07 06:37:28'),
(12, 4, 'Hasil dari 4/1​ + 2/1​ adalah ...', '{\"A\": \"6/1\", \"B\": \"4/3\", \"C\": \"4/2\", \"D\": \"8/1\"}', 'A', 3, '2025-06-08 13:15:41', '2025-06-08 13:15:41'),
(13, 4, 'Nilai dari 6/5 − 3/1 adalah ...', '{\"A\": \"-3/4\", \"B\": \"6/4\", \"C\": \"2/1\", \"D\": \"-9/5\"}', 'D', 3, '2025-06-08 13:15:41', '2025-06-08 13:15:41'),
(14, 4, 'Hasil dari 3/2 × 5/4 adalah ...', '{\"A\": \"8/6\", \"B\": \"15/8\", \"C\": \"12/10\", \"D\": \"30/6\"}', 'B', 3, '2025-06-08 13:15:41', '2025-06-08 13:15:41'),
(15, 4, 'Himpunan bilangan prima kurang dari 10 adalah ...', '{\"A\": \"{1,2,3,5,7}\", \"B\": \"{2,3,5,7}\", \"C\": \"{0,1,2,3,5,7}\", \"D\": \"{2,3,4,5,6,7,8,9}\"}', 'B', 3, '2025-06-08 13:15:41', '2025-06-08 13:15:41'),
(16, 4, 'Jika A = {faktor dari 12}, maka anggota dari himpunan A adalah ...', '{\"A\": \"{1,2,3,4,6}\", \"B\": \"{1,2,3,4,6,12}\", \"C\": \"{1,2,3,4}\", \"D\": \"{12,24,36,…}\"}', 'B', 3, '2025-06-08 13:15:41', '2025-06-08 13:15:41'),
(17, 5, 'Nilai dari −8 + 3 adalah ...', '{\"A\": \"-11\", \"B\": \"5\", \"C\": \"-5\", \"D\": \"11\"}', 'C', 1, '2025-06-09 05:54:15', '2025-06-09 05:54:15'),
(18, 5, 'Jika suhu awal adalah −2°C dan turun 5°C, maka suhu sekarang adalah ...', '{\"A\": \"3°C\", \"B\": \"−3°C\", \"C\": \"−7°C\", \"D\": \"−5°C\"}', 'C', 1, '2025-06-09 05:54:15', '2025-06-09 05:54:15'),
(19, 5, 'Nilai dari (−10)−(3) adalah ...', '{\"A\": \"7\", \"B\": \"-13\", \"C\": \"-7\", \"D\": \"13\"}', 'B', 1, '2025-06-09 05:54:15', '2025-06-09 05:54:15'),
(20, 5, 'Urutan bilangan dari terbesar ke terkecil adalah ...', '{\"A\": \"3, 1, −1, −4\", \"B\": \"−4, −1, 1, 3\", \"C\": \"−1, −4, 1, 3\", \"D\": \"1, 3, −1, −4\"}', 'B', 1, '2025-06-09 05:54:15', '2025-06-09 05:54:15'),
(21, 5, 'Bilangan terbesar dari pilihan berikut adalah ...', '{\"A\": \"−3\", \"B\": \"0\", \"C\": \"-8\", \"D\": \"-1\"}', 'B', 1, '2025-06-09 05:54:15', '2025-06-09 05:54:15'),
(22, 6, 'Hasil dari (−9) × (−2) adalah ...', '{\"A\": \"−18\", \"B\": \"18\", \"C\": \"−7\", \"D\": \"7\"}', 'B', 2, '2025-06-09 05:56:30', '2025-06-09 05:56:30'),
(23, 6, 'Nilai dari (−15) ÷ 3 adalah ...', '{\"A\": \"5\", \"B\": \"-5\", \"C\": \"-18\", \"D\": \"12\"}', 'B', 2, '2025-06-09 05:56:30', '2025-06-09 05:56:30'),
(24, 6, 'Hasil dari 10 − (−3) adalah ...', '{\"A\": \"13\", \"B\": \"−13\", \"C\": \"7\", \"D\": \"-7\"}', 'A', 2, '2025-06-09 05:56:30', '2025-06-09 05:56:30'),
(25, 6, 'Nilai dari 4 + (−2) × 6 adalah ...', '{\"A\": \"12\", \"B\": \"-8\", \"C\": \"-4\", \"D\": \"16\"}', 'B', 2, '2025-06-09 05:56:30', '2025-06-09 05:56:30'),
(26, 6, 'Hasil dari (−8) + 12 ÷ 4 adalah ...', '{\"A\": \"−5\", \"B\": \"−2\", \"C\": \"1\", \"D\": \"−3\"}', 'A', 2, '2025-06-09 05:56:30', '2025-06-09 05:56:30'),
(27, 7, 'Nilai dari ½ + ⅓ adalah ...', '{\"A\": \"⅔\", \"B\": \"⅘\", \"C\": \"⁵⁄₆\", \"D\": \"¾\"}', 'C', 3, '2025-06-09 05:59:42', '2025-06-09 05:59:42'),
(28, 7, 'Hasil dari ¾ − ½ adalah ...', '{\"A\": \"¼\", \"B\": \"½\", \"C\": \"⅓\", \"D\": \"¾\"}', 'A', 3, '2025-06-09 05:59:42', '2025-06-09 05:59:42'),
(29, 7, 'Nilai dari 2 / 5 × 3 / 5 adalah ...', '{\"A\": \"6 / 25\", \"B\": \"5 / 25\", \"C\": \"10 / 25\", \"D\": \"5 / 6\"}', 'A', 3, '2025-06-09 05:59:42', '2025-06-09 05:59:42'),
(30, 7, 'Jika B = {bilangan ganjil kurang dari 10}, maka anggota himpunan B adalah ...', '{\"A\": \"{1, 3, 5, 7, 9}\", \"B\": \"{2, 4, 6, 8}\", \"C\": \"{0, 2, 4, 6, 8}\", \"D\": \"{1, 2, 3, 5, 7}\"}', 'A', 3, '2025-06-09 05:59:42', '2025-06-09 05:59:42'),
(31, 7, 'Jika C = {bilangan kelipatan 3 kurang dari 15}, maka himpunan C adalah ...', '{\"A\": \"{3, 6, 9, 12, 15}\", \"B\": \"{3, 6, 9, 12}\", \"C\": \"{0, 3, 6, 9}\", \"D\": \"{6, 9, 12}\"}', 'B', 3, '2025-06-09 05:59:42', '2025-06-09 05:59:42'),
(32, 8, 'Hasil dari (−3) + 8 adalah ...', '{\"A\": \"−11\", \"B\": \"5\", \"C\": \"−5\", \"D\": \"11\"}', 'B', 1, '2025-06-09 06:04:53', '2025-06-09 06:04:53'),
(33, 8, 'Nilai dari 6 − (−4) adalah ...', '{\"A\": \"2\", \"B\": \"-10\", \"C\": \"10\", \"D\": \"-2\"}', 'C', 1, '2025-06-09 06:04:53', '2025-06-09 06:04:53'),
(34, 8, 'Di antara bilangan berikut, manakah yang paling besar?', '{\"A\": \"−1\", \"B\": \"−3\", \"C\": \"0\", \"D\": \"-5\"}', 'C', 1, '2025-06-09 06:04:53', '2025-06-09 06:04:53'),
(35, 8, 'Urutan bilangan −2, 4, 0, −5, 3 dari yang terkecil ke terbesar adalah ...', '{\"A\": \"−5, −2, 0, 3, 4\", \"B\": \"4, 3, 0, −2, −5\", \"C\": \"−2, −5, 0, 4, 3\", \"D\": \"0, −5, −2, 3, 4\"}', 'A', 1, '2025-06-09 06:04:53', '2025-06-09 06:04:53'),
(36, 8, 'Nilai dari (−2) × (−6) adalah ...', '{\"A\": \"−12\", \"B\": \"12\", \"C\": \"−4\", \"D\": \"4\"}', 'B', 2, '2025-06-09 06:04:53', '2025-06-09 06:04:53'),
(37, 8, 'Hasil dari 15 + (−3) × 2 adalah ...', '{\"A\": \"24\", \"B\": \"9\", \"C\": \"−24\", \"D\": \"−9\"}', 'B', 2, '2025-06-09 06:04:53', '2025-06-09 06:04:53'),
(38, 8, 'Nilai dari 18 ÷ (−3) + 2 adalah ...', '{\"A\": \"4\", \"B\": \"−4\", \"C\": \"−6\", \"D\": \"6\"}', 'B', 2, '2025-06-09 06:04:53', '2025-06-09 08:01:26'),
(39, 8, 'Nilai dari  3/4 + 1/2  adalah ...', '{\"A\": \"4/6\", \"B\": \"5/4\", \"C\": \"3/8\", \"D\": \"1/4\"}', 'B', 3, '2025-06-09 06:04:53', '2025-06-09 06:04:53'),
(40, 8, 'Jika B = {bilangan ganjil kurang dari 10}, maka anggota himpunan B adalah ...', '{\"A\": \"{1, 2, 3, 5, 7, 9}\", \"B\": \"{1, 3, 5, 7, 9}\", \"C\": \"{2, 4, 6, 8}\", \"D\": \"{1, 3, 5, 7}\"}', 'B', 3, '2025-06-09 06:04:53', '2025-06-09 06:04:53'),
(41, 8, 'Hasil dari 5/6 - 1/3 adalah', '{\"A\": \"3/6\", \"B\": \"2/9\", \"C\": \"5/9\", \"D\": \"6/9\"}', 'A', 3, '2025-06-09 06:04:53', '2025-06-09 06:04:53');

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` bigint UNSIGNED NOT NULL,
  `jadwal_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `jadwal_id`, `title`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'Soal Level 1 (Dasar Bilangan Bulat)', 'Petunjuk: Pilihlah jawaban yang paling tepat!', '2025-06-06 19:01:26', '2025-06-06 19:01:26'),
(3, 1, 'Soal Level 2 (Perkalian, Pembagian, dan Operasi Campuran Bilangan Bulat)', 'Petunjuk: Pilihlah jawaban yang paling tepat!', '2025-06-07 06:37:28', '2025-06-07 06:37:28'),
(4, 1, 'Soal Level 3 (Pecahan dan Himpunan Dasar)', 'Petunjuk: Pilihlah jawaban yang paling tepat!', '2025-06-08 13:15:41', '2025-06-08 13:15:41'),
(5, 1, 'Level 1 - Dasar Bilangan Bulat', 'Petunjuk: Pilihlah jawaban yang paling tepat!', '2025-06-09 05:54:15', '2025-06-09 05:54:15'),
(6, 1, 'Level 2 – Perkalian, Pembagian, dan Operasi Campuran', 'Petunjuk: Pilihlah jawaban yang paling tepat!', '2025-06-09 05:56:30', '2025-06-09 05:56:30'),
(7, 1, 'Level 3 – Pecahan dan Himpunan Dasar', 'Petunjuk: Pilihlah jawaban yang paling tepat!', '2025-06-09 05:59:42', '2025-06-09 05:59:42'),
(8, 1, 'Kuis Entry – Penempatan Level', 'Petunjuk: Pilihlah jawaban yang paling tepat!', '2025-06-09 06:04:53', '2025-06-09 06:04:53');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'SISWA', '2025-05-29 10:48:26', '2025-05-29 10:48:26'),
(2, 'GURU', '2025-05-29 10:48:26', '2025-05-29 10:48:26'),
(3, 'ADMIN', '2025-05-29 10:48:26', '2025-05-29 10:48:26');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('6FKIv6GdMGOOxiwn0JRlPd7rpvw8lGENiAOtD7WT', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVkZLcVdkano3RFR4Yks0Z05mc1lib1pFTEFDQm5hUG5SS2FEbW41VyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748942582),
('M3x6zRz5psU8o11Pm1kKgjBAl6QtL27tvJTsPQfF', NULL, '127.0.0.1', 'PostmanRuntime/7.44.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUVI1bDJaVlV2N202T3JtbGxwODN0UWd6MVE0b1FSNW9NaWc2V01LUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748942558);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `singkatan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `name`, `code`, `singkatan`, `created_at`, `updated_at`) VALUES
(1, 'Matematika', 'SMP-701', 'MTK', '2025-06-02 22:42:09', '2025-06-06 16:05:02'),
(2, 'Ilmu Pengetahuan Alam', 'SMP-702', 'IPA', '2025-06-02 22:42:15', '2025-06-06 16:04:51'),
(3, 'Ilmu Pengetahuan Sosial', 'SD-103', 'IPS', '2025-06-02 22:42:27', '2025-06-05 10:48:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `profile_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('L','P') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `tahun_masuk` year DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role_id`, `profile_name`, `profile_path`, `gender`, `tanggal_lahir`, `tahun_masuk`, `address`) VALUES
(1, 'Test', 'test@example.com', NULL, '$2y$12$ahZbvnQqOIbYqAixKz3JPeDZAIKa9DWNY6mmMPL08kYwHayQlBem.', NULL, '2025-05-29 10:48:26', '2025-06-05 11:25:39', 3, '', '', NULL, NULL, NULL, NULL),
(2, 'John Doe', 'john@example.com', NULL, '$2y$12$ZcpowllXoYYibB82Kb8zdOzrODP4RlhqyoIT42Oavgfoe89dmVEm6', NULL, '2025-05-29 10:49:05', '2025-05-29 10:49:05', 2, '', '', NULL, NULL, NULL, NULL),
(6, 'Ariq Bagus Sugiharto', 'ariqbagus19@gmail.com', NULL, '$2y$12$z2rsScAXL8UMF69vlTeBu.l1dkC0Q40vJyEvfOdCpd1iqxLB4QfJe', NULL, '2025-05-29 23:40:57', '2025-06-06 16:37:01', 1, '1749227376_foto2.jpeg', 'profile/1749227376_foto2.jpeg', 'L', '2003-09-19', 2025, 'Kopo'),
(7, 'Admin', 'admin@gmail.com', NULL, '$2y$12$3lvpwb3IRAUIuQNVXLPCluMIw0E33sU4OYoGSiEuUSCLl9LODEtgy', NULL, '2025-06-02 06:30:38', '2025-06-06 16:25:02', 3, '', '', NULL, NULL, NULL, NULL),
(9, 'Muhammad Fadlansyah Zikri', 'fadlanzikri11@gmail.com', NULL, '$2y$12$GLHmmD12l95XMJDoLloULOHP19UWXBbNd6ALT1tRZnGDVnu0D9I6S', NULL, '2025-06-02 21:58:07', '2025-06-06 15:51:02', 1, '1749224895_q1 (2).jpg', 'profile/1749224895_q1 (2).jpg', 'L', '2003-06-11', 2025, 'Bau-bau'),
(10, 'Ramzi Syuhada', 'ramzi@gmail.com', NULL, '$2y$12$3hxSiWuvJgf7VCqpoABBDe9hzkzIZGNcCmSg03L0L.7l/c6/VHYxy', NULL, '2025-06-02 23:43:55', '2025-06-08 21:10:02', 1, '', '', 'L', '2003-06-24', 2025, 'Rancaekek'),
(11, 'Diash Firdaus', 'diash@gmail.com', NULL, '$2y$12$YLKO.eVaRRVAyodtCfmocujdci3KIebOnqImeGfdLnuzTTO5IhFLK', NULL, '2025-06-03 01:46:02', '2025-06-03 01:46:02', 2, '', '', NULL, NULL, NULL, NULL),
(12, 'Muhammad Arkan Adli', 'arkan@gmail.com', NULL, '$2y$12$l3jDdNGnH7.AirlrZsbtj.AB7ibdtHuJeC0ZNUYepe1Jzp3kwxuau', NULL, '2025-06-04 04:47:21', '2025-06-04 04:47:43', 1, '', '', NULL, NULL, NULL, NULL),
(13, 'Lionel Messi', 'sarah@gmail.com', NULL, '$2y$12$Tv3udHNR9.RWfGcl0WEOjepE6WVrMMkcMhSPwAv2edBfhJSIcDUZm', NULL, '2025-06-04 09:54:34', '2025-06-04 10:29:25', 2, '', '', NULL, NULL, NULL, NULL),
(14, 'Cristiano Ronaldo', 'cristiano@gmail.com', NULL, '$2y$12$9z1w3oMUITqza.y0SKueOuxBWCwPwqB3pN5/5W1MLUAtuEQ8VtiMq', NULL, '2025-06-05 11:26:04', '2025-06-05 11:26:42', 1, '', '', NULL, NULL, NULL, NULL),
(15, 'Lamine Yamal', 'lamine@gmail.com', NULL, '$2y$12$zVBUZsJdIGDd10Lw61INgOG3JGecL6ZBpab6DVaDQv/cZP9IK4Af2', NULL, '2025-06-05 11:27:02', '2025-06-05 11:27:02', 2, '', '', NULL, NULL, NULL, NULL),
(16, 'Fathia Ayunia Maulani', 'fathiayunia@gmail.com', NULL, '$2y$12$uD8CeN4pBsh5KOuFMWr01uj0mz02YERMz9e1x5fnHR50s.abvWWI6', NULL, '2025-06-06 16:02:14', '2025-06-06 16:03:34', 2, NULL, NULL, 'P', '1996-07-30', 2020, 'Kopo');

-- --------------------------------------------------------

--
-- Table structure for table `user_answers`
--

CREATE TABLE `user_answers` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `question_id` bigint UNSIGNED NOT NULL,
  `selected_answer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attempt_number` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_answers`
--

INSERT INTO `user_answers` (`id`, `user_id`, `question_id`, `selected_answer`, `is_correct`, `created_at`, `updated_at`, `attempt_number`) VALUES
(11, 6, 32, 'B', 1, NULL, NULL, 1),
(12, 6, 33, 'C', 1, NULL, NULL, 1),
(13, 6, 34, 'C', 1, NULL, NULL, 1),
(14, 6, 35, 'A', 1, NULL, NULL, 1),
(15, 6, 36, 'B', 1, NULL, NULL, 1),
(16, 6, 37, 'B', 1, NULL, NULL, 1),
(17, 6, 38, 'B', 1, NULL, NULL, 1),
(18, 6, 39, 'B', 1, NULL, NULL, 1),
(19, 6, 40, 'B', 1, NULL, NULL, 1),
(20, 6, 41, 'A', 1, NULL, NULL, 1),
(21, 9, 32, 'C', 0, NULL, NULL, 1),
(22, 9, 33, 'B', 0, NULL, NULL, 1),
(23, 9, 34, 'B', 0, NULL, NULL, 1),
(24, 9, 35, 'B', 0, NULL, NULL, 1),
(25, 9, 36, 'A', 0, NULL, NULL, 1),
(26, 9, 37, 'A', 0, NULL, NULL, 1),
(27, 9, 38, 'D', 0, NULL, NULL, 1),
(28, 9, 39, 'C', 0, NULL, NULL, 1),
(29, 9, 40, 'A', 0, NULL, NULL, 1),
(30, 9, 41, 'B', 0, NULL, NULL, 1),
(31, 9, 1, 'C', 1, NULL, NULL, 1),
(32, 9, 2, 'B', 1, NULL, NULL, 1),
(33, 9, 3, 'C', 0, NULL, NULL, 1),
(34, 9, 4, 'B', 1, NULL, NULL, 1),
(35, 9, 5, 'A', 1, NULL, NULL, 1),
(36, 9, 1, 'A', 0, NULL, NULL, 2),
(37, 9, 2, 'A', 0, NULL, NULL, 2),
(38, 9, 3, 'A', 0, NULL, NULL, 2),
(39, 9, 4, 'A', 0, NULL, NULL, 2),
(40, 9, 5, 'B', 0, NULL, NULL, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensis`
--
ALTER TABLE `absensis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `absensis_jadwal_user_id_foreign` (`jadwal_user_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jadwals`
--
ALTER TABLE `jadwals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jadwals_kelas_id_foreign` (`kelas_id`),
  ADD KEY `jadwals_subject_id_foreign` (`subject_id`),
  ADD KEY `jadwals_guru_id_foreign` (`guru_id`);

--
-- Indexes for table `jadwal_users`
--
ALTER TABLE `jadwal_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `jadwal_user_jadwal_id_user_id_unique` (`jadwal_id`,`user_id`),
  ADD KEY `jadwal_user_user_id_foreign` (`user_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `materis`
--
ALTER TABLE `materis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `materis_subject_id_foreign` (`jadwal_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questions_quiz_id_foreign` (`quiz_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- Indexes for table `user_answers`
--
ALTER TABLE `user_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_answers_user_id_foreign` (`user_id`),
  ADD KEY `user_answers_question_id_foreign` (`question_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensis`
--
ALTER TABLE `absensis`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jadwals`
--
ALTER TABLE `jadwals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jadwal_users`
--
ALTER TABLE `jadwal_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `materis`
--
ALTER TABLE `materis`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user_answers`
--
ALTER TABLE `user_answers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensis`
--
ALTER TABLE `absensis`
  ADD CONSTRAINT `absensis_jadwal_user_id_foreign` FOREIGN KEY (`jadwal_user_id`) REFERENCES `jadwal_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jadwals`
--
ALTER TABLE `jadwals`
  ADD CONSTRAINT `jadwals_guru_id_foreign` FOREIGN KEY (`guru_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jadwals_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jadwals_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jadwal_users`
--
ALTER TABLE `jadwal_users`
  ADD CONSTRAINT `jadwal_user_jadwal_id_foreign` FOREIGN KEY (`jadwal_id`) REFERENCES `jadwals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jadwal_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `materis`
--
ALTER TABLE `materis`
  ADD CONSTRAINT `materis_subject_id_foreign` FOREIGN KEY (`jadwal_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_answers`
--
ALTER TABLE `user_answers`
  ADD CONSTRAINT `user_answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
