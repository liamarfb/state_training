import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/course_api_service.dart'; // Import service baru
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/responsive_shell.dart';

// URL dasar tanpa '/courses', karena endpoint dirakit di dalam Service
const String apiUrl = 'https://course-api-pearl.vercel.app'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 

  // Injeksi dependensi arsitektur
  final apiService = CourseApiService(apiUrl);
  final repository = CourseRepository(apiService);

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