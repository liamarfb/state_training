import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase

import 'services/course_api_service.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/responsive_shell.dart';
import 'supabase_config.dart'; // Import file konfigurasi yang baru dibuat

// URL API Latihan (masih dipakai sementara)
const String apiUrl = 'https://course-api-pearl.vercel.app'; 

Future<void> main() async {
  // Wajib dipanggil jika main() menggunakan async
  WidgetsFlutterBinding.ensureInitialized(); 

  // Inisialisasi Supabase menggunakan variabel dari supabase_config.dart
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  // Perakitan arsitektur tetap dilakukan setelah inisialisasi
  final repository = CourseRepository(CourseApiService(apiUrl));

  runApp(
    ChangeNotifierProvider(
      create: (context) => CourseProvider(repository)..loadCourses(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ResponsiveShell(),
      debugShowCheckedModeBanner: false,
    );
  }
}