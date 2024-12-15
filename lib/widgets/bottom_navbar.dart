import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 76,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFFD9D9D9),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            icon: Icons.home,
            label: 'Home',
            index: 0,
          ),
          _buildNavItem(
            context,
            icon: Icons.photo_album,
            label: 'Gallery',
            index: 1,
          ),
          _buildNavItem(
            context,
            icon: Icons.event,
            label: 'Events',
            index: 2,
          ),
          _buildNavItem(
            context,
            icon: Icons.article,
            label: 'Articles',
            index: 3,
          ),
          _buildNavItem(
            context,
            icon: Icons.timeline,
            label: 'Timeline',
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {required IconData icon, required String label, required int index}) {
    final bool isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFD88E30) : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFFD88E30) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
