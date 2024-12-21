import 'package:flutter/material.dart';
import 'package:batikalongan_mobile/article/screens/artikel_screen.dart';
import 'package:batikalongan_mobile/gallery/screens/gallery_screen.dart';
import 'package:batikalongan_mobile/catalog/screens/menu.dart';
import '../widgets/bottom_navbar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const GalleryScreen(),
    const GalleryScreen(),
    const GalleryScreen(),
    const ArtikelScreen(),
    const ArtikelScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
