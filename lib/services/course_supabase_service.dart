import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course.dart';
import 'course_data_source.dart';

// Nama: Liam Arta Febrio 
// NIM: 2415051087
class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  // TAHAP 12: Fungsi SELECT (Membaca Data)
  @override
  Future<List<Course>> getCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('id');

    return (data as List)
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // TAHAP 13: Fungsi INSERT (Tambah Data)
  @override
  Future<Course> createCourse(Course course) async {
    final row = await supabase
        .from('courses')
        .insert(course.toJson())
        .select()
        .single();

    return Course.fromJson(row);
  }

  // TAHAP 14: Fungsi UPDATE (Ubah Data)
  @override
  Future<void> updateCourse(int id, Course course) async {
    await supabase
        .from('courses')
        .update(course.toJson())
        .eq('id', id);
  }

  // --- JANGAN DIHAPUS DULU (Stub untuk Tahap 15 nanti) ---
  @override
  Future<void> deleteCourse(int id) => throw UnimplementedError();
}