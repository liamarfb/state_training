import 'package:flutter/material.dart';
import 'home_page.dart';
import 'courses_page.dart';
import 'favorites_page.dart'; // Import halaman baru
import 'profile_page.dart';

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});
  
  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _currentIndex = 0;
  
  // Tambahkan FavoritesPage ke dalam list _pages
  final List<Widget> _pages = const [
    HomePage(), 
    CoursesPage(), 
    FavoritesPage(), // Index 2
    ProfilePage()    // Index 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer v2'), // Ubah di sini
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
                    // Tambahan menu di mode tablet/desktop
                    NavigationRailDestination(icon: Icon(Icons.favorite), label: Text('Favorites')),
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
                  // Tambahan menu di mode mobile
                  NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
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