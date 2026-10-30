import 'dart:convert';
import 'package:flutter/services.dart';
import '../course.dart'; // Wajib di-import agar dikenali sebagai List<Course>

class CourseService {
  // Pastikan tipe kembaliannya adalah Future<List<Course>>
  Future<List<Course>> loadCourses() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/student_data.json',
    );
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final list = data['courses'] as List<dynamic>;

    // Bagian ini wajib ada untuk mengubah tipe Map menjadi Object Course
    return list
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}