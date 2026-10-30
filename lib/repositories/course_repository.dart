import '../services/course_service.dart';
import '../course.dart';

class CourseRepository{
  final CourseService service;
  CourseRepository(this.service);
  Future<List<Course>> getCourses() {
    return service.loadCourses();
  }
}