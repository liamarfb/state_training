import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert'; // Tambahan untuk jsonDecode
import 'package:http/http.dart' as http; // Tambahan package http

// Import dari folder
import 'services/course_service.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/responsive_shell.dart';

const String apiUrl = 'https://course-api-pearl.vercel.app/courses';

Future<List<dynamic>> fetchCoursesTemp() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List<dynamic>;
    return data;
  }

  throw Exception('HTTP Error: ${response.statusCode}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  // 3. Tampilkan jumlah item pada debugPrint (Tahap 2)
  try {
    debugPrint('Mencoba mengambil data dari API...');
    final apiData = await fetchCoursesTemp();
    debugPrint('SUKSES! BERHASIL MENGAMBIL ${apiData.length} MATA KULIAH DARI API');
  } catch (e) {
    debugPrint('GAGAL: $e');
  }
  
  // (Kode inisialisasi arsitektur sebelumnya tetap berjalan pakai JSON lokal sementara)
  final service = CourseService();
  final repository = CourseRepository(service);

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