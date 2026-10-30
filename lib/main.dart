import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_provider.dart';

const String studentName = 'Liam Arta Febrio'; 
const String studentId = '2415051087'; 

// Data Statik Course
final List<Map<String, dynamic>> coursesData = [
  {'title': 'Pemrograman Mobile', 'code': 'PTI123', 'sks': 3, 'desc': 'Belajar Flutter & Dart.'},
  {'title': 'Jaringan Komputer', 'code': 'PTI124', 'sks': 3, 'desc': 'Topologi, Subnetting, dan Cisco.'},
  {'title': 'Sistem Basis Data', 'code': 'PTI125', 'sks': 4, 'desc': 'MySQL, Relasi, dan Normalisasi.'},
  {'title': 'Kecerdasan Buatan', 'code': 'PTI126', 'sks': 3, 'desc': 'Fuzzy Logic, AI, Python.'},
  {'title': 'Sistem Informasi Geografis', 'code': 'PTI127', 'sks': 3, 'desc': 'WebGIS, Pemetaan, Spasial.'},
  {'title': 'Pemrograman Web', 'code': 'PTI128', 'sks': 3, 'desc': 'Laravel, Tailwind, PHP.'},
];

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(),
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

// ==========================================
// 1. RESPONSIVE SHELL (Tahap 3 - Lifting State Up)
// ==========================================
class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});
  
  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _currentIndex = 0;
  
  // TAHAP 3: State ditarik ke atas (parent)
  Set<String> favoriteCourses = {};

  void toggleFavorite(String code) {
    setState(() {
      if (favoriteCourses.contains(code)) {
        favoriteCourses.remove(code);
      } else {
        favoriteCourses.add(code);
      }
    });
  }

  // Fungsi untuk menggantikan _pages agar bisa passing data (Tahap 2)
  Widget _buildPage(int index) {
    switch (index) {
      case 0: return HomePage(); // Hapus 'const' karena HomePage sekarang dinamis (Tahap 4)
      case 1: return CoursesPage(
          favorites: favoriteCourses,
          onToggle: toggleFavorite,
        );
      case 2: return const ProfilePage();
      default: return HomePage(); // Hapus 'const' juga
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 840) {
            return Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) => setState(() => _currentIndex = index),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                    NavigationRailDestination(icon: Icon(Icons.school), label: Text('Courses')),
                    NavigationRailDestination(icon: Icon(Icons.person), label: Text('Profile')),
                  ],
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: _buildPage(_currentIndex)),
              ],
            );
          }
          return Column(
            children: [
              Expanded(child: _buildPage(_currentIndex)),
              NavigationBar(
                selectedIndex: _currentIndex,
                onDestinationSelected: (index) => setState(() => _currentIndex = index),
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(icon: Icon(Icons.school), label: 'Courses'),
                  NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// ==========================================
// 2. PAGES (Home, Courses, Profile)
// ==========================================

// TAHAP 4: Eksperimen ValueNotifier dan ValueListenableBuilder
class HomePage extends StatelessWidget {
  final ValueNotifier<int> counter = ValueNotifier(0);
  
  HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.explore, size: 80, color: Colors.indigo),
          const SizedBox(height: 20),
          const Text('Selamat Datang di Course Explorer!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('$studentId - $studentName', style: const TextStyle(fontSize: 18, color: Colors.grey)),
          
          const SizedBox(height: 50),
          const Text('Eksperimen ValueNotifier:', style: TextStyle(color: Colors.indigo)),
          const SizedBox(height: 10),
          
          // ValueListenableBuilder hanya merender ulang bagian Teks ini saja!
          ValueListenableBuilder<int>(
            valueListenable: counter,
            builder: (context, value, child) {
              return Text(
                'Jumlah Klik: $value',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            },
          ),
          const SizedBox(height: 10),
          
          ElevatedButton(
            onPressed: () {
              counter.value++; // Ubah nilai, UI otomatis update
            },
            child: const Text('Tambah Klik'),
          ),
        ],
      ),
    );
  }
}

// TAHAP 2: Prop Drilling di halaman Courses
class CoursesPage extends StatelessWidget {
  final Set<String> favorites;
  final Function(String) onToggle;

  const CoursesPage({super.key, required this.favorites, required this.onToggle});
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return ListView.builder(
            itemCount: coursesData.length,
            itemBuilder: (context, index) => CourseItemCard(
              course: coursesData[index],
              isFavorite: favorites.contains(coursesData[index]['code']),
              onToggle: onToggle,
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth < 840 ? 2 : 3,
            childAspectRatio: 2.5,
          ),
          itemCount: coursesData.length,
          itemBuilder: (context, index) => CourseItemCard(
            course: coursesData[index],
            isFavorite: favorites.contains(coursesData[index]['code']),
            onToggle: onToggle,
          ),
        );
      },
    );
  }
}

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
          Text('Nama: $studentName\nNIM: $studentId', style: const TextStyle(fontSize: 16)),
          const Divider(height: 40),
          Text('Tinggalkan Feedback', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          const FeedbackFormWidget(), 
        ],
      ),
    );
  }
}

// ==========================================
// 3. REUSABLE WIDGETS & DETAILS
// ==========================================

// TAHAP 2: Prop Drilling di dalam Card
class CourseItemCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final bool isFavorite;
  final Function(String) onToggle;

  const CourseItemCard({super.key, required this.course, required this.isFavorite, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo, 
          child: Text(course['code'].toString().substring(3), style: const TextStyle(color: Colors.white))
        ),
        title: Text(course['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${course['code']} - ${course['sks']} SKS'),
        trailing: Icon(isFavorite ? Icons.favorite : Icons.chevron_right, color: isFavorite ? Colors.red : null),
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (_) => CourseDetailPage(
              course: course,
              isFavorite: isFavorite, 
              onToggle: onToggle, 
            ))
          );
        },
      ),
    );
  }
}

// TAHAP 2: Tujuan akhir Prop Drilling
class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;
  final bool isFavorite;
  final Function(String) onToggle;

  const CourseDetailPage({super.key, required this.course, required this.isFavorite, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course['title']), 
        backgroundColor: Colors.indigo, 
        foregroundColor: Colors.white
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Kode: ${course['code']}', style: const TextStyle(fontSize: 16)),
            Text('SKS: ${course['sks']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Deskripsi: ${course['desc']}', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  onToggle(course['code']); 
                  Navigator.pop(context); 
                },
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : null),
                label: Text(isFavorite ? 'Hapus Favorite' : 'Tambah Favorite'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackFormWidget extends StatefulWidget {
  const FeedbackFormWidget({super.key});
  
  @override
  State<FeedbackFormWidget> createState() => _FeedbackFormWidgetState();
}

class _FeedbackFormWidgetState extends State<FeedbackFormWidget> {
  final _formKey = GlobalKey<FormState>();

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Kirim Feedback?'),
          content: const Text('Pastikan data sudah benar.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feedback berhasil dikirim!'))
                );
              },
              child: const Text('Kirim'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Komentar', border: OutlineInputBorder()),
            maxLines: 3,
            validator: (value) => (value == null || value.length < 5) ? 'Komentar minimal 5 karakter' : null,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitFeedback, 
              child: const Text('Submit Feedback')

              
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// TAHAP 5: ChangeNotifier & notifyListeners()
// ==========================================
class CourseProvider extends ChangeNotifier {
  // Collection untuk menyimpan kode mata kuliah yang difavoritkan
  final Set<String> favorites = {};

  // Method untuk menambah/menghapus favorit
  void toggleFavorite(String code) {
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }
    
    // Ini sangat penting! Berfungsi memberi tahu widget yang 'mendengar'
    // bahwa ada perubahan data sehingga mereka harus me-rebuild UI.
    notifyListeners();
  }
}