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
}