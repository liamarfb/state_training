import 'package:flutter/material.dart';
import '../widgets/feedback_form_widget.dart';

const String studentName = 'Liam Arta Febrio'; 
const String studentId = '2415051087'; 

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profil Mahasiswa', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 10),
          const Text('Nama: $studentName\nNIM: $studentId', style: TextStyle(fontSize: 16)),
          const Divider(height: 40),
          Text('Tinggalkan Feedback', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          const FeedbackFormWidget(), 
        ],
      ),
    );
  }
}