import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_provider.dart';
import 'course.dart'; // Import model
import 'services/course_service.dart'; // Import service Tahap 9

const String studentName = 'Liam Arta Febrio'; 
const String studentId = '2415051087'; 

// Data Statik Course (Sementara masih dipakai UI sebelum diganti Provider di Tahap 10)
final List<Course> coursesData = [
  Course(title: 'Pemrograman Mobile', code: 'PTI123', sks: 3, desc: 'Belajar Flutter & Dart.'),
  Course(title: 'Jaringan Komputer', code: 'PTI124', sks: 3, desc: 'Topologi, Subnetting, dan Cisco.'),
  Course(title: 'Sistem Basis Data', code: 'PTI125', sks: 4, desc: 'MySQL, Relasi, dan Normalisasi.'),
  Course(title: 'Kecerdasan Buatan', code: 'PTI126', sks: 3, desc: 'Fuzzy Logic, AI, Python.'),
  Course(title: 'Sistem Informasi Geografis', code: 'PTI127', sks: 3, desc: 'WebGIS, Pemetaan, Spasial.'),
  Course(title: 'Pemrograman Web', code: 'PTI128', sks: 3, desc: 'Laravel, Tailwind, PHP.'),
];

// TAHAP 9: Ubah main menjadi async untuk menguji service
void main() async {
  // Wajib dipanggil jika ada proses async sebelum runApp
  WidgetsFlutterBinding.ensureInitialized(); 
  
  // Uji coba service dari Tahap 9
  try {
    final service = CourseService();
    final courses = await service.loadCourses();
    debugPrint('BERHASIL MEMUAT ${courses.length} MATA KULIAH DARI JSON');
  } catch (e) {
    debugPrint('Error memuat data JSON: $e');
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => CourseProvider(),
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
// 1. RESPONSIVE SHELL
// ==========================================
class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});
  
  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = const [
    HomePage(), 
    CoursesPage(), 
    ProfilePage()
  ];

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
                Expanded(child: _pages[_currentIndex]),
              ],
            );
          }
          return Column(
            children: [
              Expanded(child: _pages[_currentIndex]),
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
          Text('$studentId - $studentName', style: const TextStyle(fontSize: 18, color: Colors.grey)),
          
          const SizedBox(height: 40),
          Text('Jumlah Favorite: $favoriteCount', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
        ],
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return ListView.builder(
            itemCount: coursesData.length,
            itemBuilder: (context, index) => CourseItemCard(
              course: coursesData[index],
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
class CourseItemCard extends StatelessWidget {
  // TAHAP 8: Tipe data diganti menjadi Object Course (bukan Map lagi)
  final Course course;
  
  const CourseItemCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo, 
          // Menggunakan properti object (.code) bukan key map (['code'])
          child: Text(course.code.substring(3), style: const TextStyle(color: Colors.white))
        ),
        title: Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${course.code} - ${course.sks} SKS'),
        
        trailing: Consumer<CourseProvider>(
          builder: (context, provider, child) {
            final isFavorite = provider.favorites.contains(course.code);
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

class CourseDetailPage extends StatelessWidget {
  final Course course;
  
  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<CourseProvider>().favorites.contains(course.code);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title), 
        backgroundColor: Colors.indigo, 
        foregroundColor: Colors.white
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Kode: ${course.code}', style: const TextStyle(fontSize: 16)),
            Text('SKS: ${course.sks}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Deskripsi: ${course.desc}', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<CourseProvider>().toggleFavorite(course.code); 
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