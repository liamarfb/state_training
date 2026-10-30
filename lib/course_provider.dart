import 'package:flutter/material.dart';
import 'repositories/course_repository.dart';
import 'course.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository; // Menerima repository dari luar
  
  CourseProvider(this.repository); 

  final Set<String> favorites = {};
  
  // Tempat menyimpan data mata kuliah dari JSON nanti
  List<Course> courses = []; 

  // Method untuk memuat data via Repository
  Future<void> loadCoursesData() async {
    courses = await repository.getCourses();
    notifyListeners();
  }

  void toggleFavorite(String code) {
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }
    notifyListeners();
  }
}