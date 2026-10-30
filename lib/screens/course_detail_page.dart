import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import 'course_edit_page.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  // TAHAP 8: Fungsi memunculkan dialog konfirmasi dan eksekusi hapus
  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Yakin ingin menghapus mata kuliah ${course.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    // Jika user menekan batal atau tap di luar dialog
    if (confirm != true) return; 

    // Guard setelah await dialog
    if (!context.mounted) return;

    final provider = context.read<CourseProvider>();
    
    // Tampilkan indikator loading (opsional) atau langsung hapus
    final success = await provider.removeCourse(course);

    // Guard setelah await hapus jaringan
    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil menghapus mata kuliah'), backgroundColor: Colors.green),
      );
      Navigator.pop(context); // Keluar dari halaman detail kembali ke list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.error ?? 'Gagal menghapus data'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mata Kuliah'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          // TAHAP 7: Tombol Edit
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
          // TAHAP 8: Tombol Delete
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.redAccent,
            tooltip: 'Hapus Course',
            onPressed: () => _showDeleteConfirmation(context),
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
            Text('Kode: ${course.code}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('SKS: ${course.credits}', style: const TextStyle(fontSize: 16)),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active': return Colors.green;
      case 'done': return Colors.blue;
      case 'planned': default: return Colors.orange;
    }
  }
}