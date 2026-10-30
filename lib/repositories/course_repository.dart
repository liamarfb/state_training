import '../services/course_api_service.dart';
import '../models/course.dart';

class CourseRepository {
  final CourseApiService apiService;

  CourseRepository(this.apiService);

  Future<List<Course>> getCourses() {
    return apiService.getCourses();
  }

  // TAHAP 6: Fungsi POST dari service
  Future<Course> createCourse(Course course) {
    return apiService.createCourse(course);
  }

  // TAHAP 7: Fungsi PUT (Meneruskan dari Service)
  Future<void> updateCourse(int id, Course course) {
    return apiService.updateCourse(id, course);
  }

  // TAHAP 8: Fungsi DELETE (Meneruskan dari Service)
  Future<void> deleteCourse(int id) {
    return apiService.deleteCourse(id);
  }
}