import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/responsive_shell.dart';
import 'services/course_supabase_service.dart'; // Menggunakan Supabase service
import 'supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  // Inisialisasi Supabase (menggunakan 'publishableKey' sesuai update terbaru SDK)
  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: supabaseAnonKey, 
  );

  // Perakitan arsitektur (hanya dideklarasikan SATU KALI di sini)
  final repository = CourseRepository(CourseSupabaseService());

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