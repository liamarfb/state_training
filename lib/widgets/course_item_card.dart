import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../models/course.dart';
import '../screens/course_detail_page.dart';

class CourseItemCard extends StatelessWidget {
  final Course course;
  
  const CourseItemCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo, 
          child: Text(course.code.substring(3), style: const TextStyle(color: Colors.white))
        ),
        title: Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${course.code} - ${course.credits} SKS'),
            Text('Status: ${course.status}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
        
        trailing: Consumer<CourseProvider>(
          builder: (context, provider, child) {
            // Gunakan fungsi isFavorite sesuai modul
            final isFavorite = provider.isFavorite(course.code); 
            return Icon(
              isFavorite ? Icons.favorite : Icons.chevron_right, 
              color: isFavorite ? Colors.red : null
            );
          },
        ),
        
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (_) => CourseDetailPage(course: course))
          );
        },
      ),
    );
  }
}