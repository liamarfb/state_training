import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_item_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pantau provider dan ambil list course yang difavoritkan
    final provider = context.watch<CourseProvider>();
    final favoriteCourses = provider.favoriteCoursesList;

    if (favoriteCourses.isEmpty) {
      return const Center(
        child: Text('Belum ada mata kuliah favorit.', style: TextStyle(fontSize: 16)),
      );
    }

    // Tampilkan menggunakan Card yang sama (Reusable Widget)
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return ListView.builder(
            itemCount: favoriteCourses.length,
            itemBuilder: (context, index) => CourseItemCard(
              course: favoriteCourses[index],
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth < 840 ? 2 : 3,
            childAspectRatio: 2.5,
          ),
          itemCount: favoriteCourses.length,
          itemBuilder: (context, index) => CourseItemCard(
            course: favoriteCourses[index],
          ),
        );
      },
    );
  }
}