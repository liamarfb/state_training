import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../models/course.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;
  
  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    // Gunakan fungsi isFavorite sesuai modul
    final isFavorite = context.watch<CourseProvider>().isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title), 
        backgroundColor: Colors.indigo, 
        foregroundColor: Colors.white
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Kode: ${course.code}', style: const TextStyle(fontSize: 16)),
            Text('SKS: ${course.sks}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Deskripsi: ${course.desc}', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<CourseProvider>().toggleFavorite(course.code); 
                },
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : null),
                label: Text(isFavorite ? 'Hapus Favorite' : 'Tambah Favorite'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}