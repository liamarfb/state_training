import 'package:flutter/material.dart';
import '../models/course.dart';
import 'course_edit_page.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mata Kuliah'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          // TAHAP 7: Tombol untuk masuk ke halaman Edit
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Course',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CourseEditPage(course: course)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Kode: ${course.code}', 
              style: const TextStyle(fontSize: 16)
            ),
            const SizedBox(height: 8),
            Text(
              'SKS: ${course.credits}', 
              style: const TextStyle(fontSize: 16)
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(course.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _getStatusColor(course.status)),
              ),
              child: Text(
                'Status: ${course.status.toUpperCase()}', 
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(course.status),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi kecil untuk memberi warna berbeda pada tiap status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'done':
        return Colors.blue;
      case 'planned':
      default:
        return Colors.orange;
    }
  }
}