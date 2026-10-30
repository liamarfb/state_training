import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_item_card.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Text('Terjadi kesalahan:\n${provider.error}', 
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red, fontSize: 16)
        )
      );
    }

    if (provider.courses.isEmpty) {
      return const Center(child: Text('Tidak ada data mata kuliah.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return ListView.builder(
            itemCount: provider.courses.length,
            itemBuilder: (context, index) => CourseItemCard(
              course: provider.courses[index],
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth < 840 ? 2 : 3,
            childAspectRatio: 2.5,
          ),
          itemCount: provider.courses.length,
          itemBuilder: (context, index) => CourseItemCard(
            course: provider.courses[index],
          ),
        );
      },
    );
  }
}