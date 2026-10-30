import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';

const String studentName = 'Liam Arta Febrio'; 
const String studentId = '2415051087'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Ambil data jumlah course dan favorit dari Provider
    final provider = context.watch<CourseProvider>();
    final courseCount = provider.courses.length;
    final favoriteCount = provider.favorites.length;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Card Identitas
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10)
          ),
          child: const Text(
            '$studentId • $studentName',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E3A8A)), // Warna biru gelap
          ),
        ),
        const SizedBox(height: 16),

        // Row Summary Cards
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard('Courses', courseCount.toString()),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSummaryCard('Favorites', favoriteCount.toString()),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // List Progres Materi
        _buildProgressItem('Git & GitHub', 'done', Colors.green),
        _buildProgressItem('Dart Fundamentals', 'done', Colors.green),
        _buildProgressItem('State Management', 'active', Colors.green),
      ],
    );
  }

  // Widget bantuan untuk kotak angka summary
  Widget _buildSummaryCard(String title, String count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade100)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF475569))), 
          const SizedBox(height: 8),
          Text(count, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
        ],
      ),
    );
  }

  // Widget bantuan untuk list progress
  Widget _buildProgressItem(String title, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E3A8A))),
          const SizedBox(height: 4),
          Text(status, style: TextStyle(fontWeight: FontWeight.bold, color: statusColor)),
        ],
      ),
    );
  }
}