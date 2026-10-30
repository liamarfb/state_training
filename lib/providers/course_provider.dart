import 'package:flutter/material.dart';
import '../repositories/course_repository.dart';
import '../models/course.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  final Set<String> favorites = {};
  
  // Variabel state hanya ditulis SATU KALI di sini
  List<Course> courses = [];
  bool isLoading = false;
  bool isSaving = false; // Tambahan Tahap 6
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

  // TAHAP 6: Fungsi memproses POST dari UI
  Future<bool> addCourse(Course course) async {
    isSaving = true;
    notifyListeners();
    
    try {
      await repository.createCourse(course);
      await loadCourses(); // Refresh list dengan memanggil dari API lagi
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

// TAHAP 7: Fungsi memproses PUT dari UI
  Future<bool> editCourse(int id, Course course) async {
    isSaving = true;
    notifyListeners();
    
    try {
      await repository.updateCourse(id, course);
      await loadCourses(); // Refresh list setelah berhasil update
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // TAHAP 8: Fungsi memproses DELETE dari UI
  Future<bool> removeCourse(Course course) async {
    if (course.id == null) return false;

    isSaving = true;
    notifyListeners();
    
    try {
      // 1. Hapus dari server
      await repository.deleteCourse(course.id!);
      
      // 2. Hapus dari daftar favorites lokal jika ada (Poin 6)
      if (favorites.contains(course.code)) {
        favorites.remove(course.code);
      }
      
      // 3. Refresh list dari server
      await loadCourses(); 
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // --- Fungsi Favorites dari tahap sebelumnya ---
  bool isFavorite(String code) => favorites.contains(code);

  void toggleFavorite(String code) {
    favorites.contains(code)
        ? favorites.remove(code)
        : favorites.add(code);
    notifyListeners();
  }

  List<Course> get favoriteCoursesList {
    return courses.where((course) => favorites.contains(course.code)).toList();
  }
}