import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_item_card.dart';
import '../widgets/error_view.dart'; // Tambahkan import ini

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    // 1. STATE LOADING
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 2. STATE ERROR
    if (provider.error != null) {
      return ErrorView(
        message: provider.error!,
        onRetry: provider.loadCourses, // Memanggil ulang method GET dari provider
      );
    }

    // 3. STATE EMPTY
    if (provider.courses.isEmpty) {
      return const Center(
        child: Text('Data course belum tersedia', style: TextStyle(fontSize: 16))
      );
    }

    // 4. STATE SUCCESS
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