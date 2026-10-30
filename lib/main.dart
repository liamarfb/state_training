import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert'; // Tambahan untuk jsonDecode
import 'package:http/http.dart' as http; // Tambahan package http

// Import dari folder
import 'services/course_service.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/responsive_shell.dart';
import 'models/course.dart';

// ... import tetap sama ...

const String apiUrl = 'https://course-api-pearl.vercel.app/courses';

// Tahap 3: Konversi response menjadi List<Course>
Future<List<Course>> fetchCoursesTemp() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    // Parsing JSON API menjadi Object Course
    return data.map((json) => Course.fromJson(json)).toList();
  }

  throw Exception('HTTP Error: ${response.statusCode}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  
  List<Course> apiCourses = [];
  
  try {
    debugPrint('Mencoba mengambil data dari API...');
    apiCourses = await fetchCoursesTemp();
    debugPrint('SUKSES! BERHASIL MENGAMBIL ${apiCourses.length} MATA KULIAH DARI API');
  } catch (e) {
    debugPrint('GAGAL: $e');
  }
  
  final service = CourseService();
  final repository = CourseRepository(service);

  runApp(
    ChangeNotifierProvider(
      create: (context) {
        final provider = CourseProvider(repository);
        // Inject data API langsung ke UI (Bypass data JSON lokal sementara)
        provider.courses = apiCourses; 
        return provider;
      },
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