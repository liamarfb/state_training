import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course.dart';
import 'course_data_source.dart';

// Nama: Liam Arta Febrio 
// NIM: 2415051087
class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    // 2. Mengambil data dari tabel 'courses' dan mengurutkannya berdasarkan 'id'
    final data = await supabase
        .from('courses')
        .select()
        .order('id');

    // 3. Mengonversi response menjadi List<Course>
    return (data as List)
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // Sementara, agar kelas tetap dapat dikompilasi
  @override
  Future<Course> createCourse(Course course) => throw UnimplementedError();

  @override
  Future<void> updateCourse(int id, Course course) => throw UnimplementedError();

  @override
  Future<void> deleteCourse(int id) => throw UnimplementedError();
}