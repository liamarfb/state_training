import 'package:flutter/material.dart';
import '../repositories/course_repository.dart';
import '../models/course.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  final Set<String> favorites = {};
  
  List<Course> courses = [];
  bool isLoading = false;
  String? error;

  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();
    
    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // --- TAMBAHAN TAHAP 13 ---
  // Fungsi cek favorite sesuai modul
  bool isFavorite(String code) => favorites.contains(code);

  // Modifikasi toggle sesuai modul (pakai ternary operator)
  void toggleFavorite(String code) {
    favorites.contains(code)
        ? favorites.remove(code)
        : favorites.add(code);
    // notifyListeners();
  }

  // Fungsi tambahan untuk mem-filter daftar course yang difavoritkan
  List<Course> get favoriteCoursesList {
    return courses.where((course) => favorites.contains(course.code)).toList();
  }
}