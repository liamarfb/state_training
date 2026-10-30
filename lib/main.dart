import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import services, repo, provider, dan screen shell
import 'services/course_service.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/responsive_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  
  final service = CourseService();
  final repository = CourseRepository(service);

  runApp(
    ChangeNotifierProvider(
      create: (context) => CourseProvider(repository)..loadCourses(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ResponsiveShell(), 
      debugShowCheckedModeBanner: false,
    );
  }
}