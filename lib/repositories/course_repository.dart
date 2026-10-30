import '../services/course_api_service.dart';
import '../models/course.dart';

class CourseRepository {
  // Pastikan di sini tipenya CourseApiService, BUKAN CourseService
  final CourseApiService apiService; 

  CourseRepository(this.apiService);

  Future<List<Course>> getCourses() {
    return apiService.getCourses(); // Memanggil getCourses dari API
  }
}