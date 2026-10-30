import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';

const String studentName = 'Liam Arta Febrio'; 
const String studentId = '2415051087'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final favoriteCount = context.watch<CourseProvider>().favorites.length;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.explore, size: 80, color: Colors.indigo),
          const SizedBox(height: 20),
          const Text('Selamat Datang di Course Explorer!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('$studentId - $studentName', style: TextStyle(fontSize: 18, color: Colors.grey)),
          
          const SizedBox(height: 40),
          Text('Jumlah Favorite: $favoriteCount', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
        ],
      ),
    );
  }
}