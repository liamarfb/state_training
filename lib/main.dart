import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/responsive_shell.dart';
import 'services/course_data_source.dart'; // Import abstract class
import 'services/course_supabase_service.dart';
import 'supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: supabaseAnonKey, 
  );

  // TAHAP 16: Penegasan implementasi Dependency Inversion
  final CourseDataSource dataSource = CourseSupabaseService();
  final repository = CourseRepository(dataSource);

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