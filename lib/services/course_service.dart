import 'dart:convert';
import 'package:flutter/services.dart';
class CourseService {
  Future<List<Map<String, dynamic>>> loadCourses() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/student_data.json',
    );
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final list = data['courses'] as List<dynamic>;
    
    return list.map((e) => e as Map<String, dynamic>).toList();
  }
}