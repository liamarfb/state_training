import '../services/course_data_source.dart'; // Import abstract class
import '../models/course.dart';

class CourseRepository {
  // Bergantung pada abstraksi, BUKAN implementasi konkret
  final CourseDataSource dataSource; 

  CourseRepository(this.dataSource);
  Future<List<Course>> getCourses() => dataSource.getCourses();
  Future<Course> createCourse(Course course) => dataSource.createCourse(course);
  Future<void> updateCourse(int id, Course course) => dataSource.updateCourse(id, course);
  Future<void> deleteCourse(int id) => dataSource.deleteCourse(id);
}