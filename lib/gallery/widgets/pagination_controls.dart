import 'package:flutter/material.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChange;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final page = index + 1;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ElevatedButton(
            onPressed: () => onPageChange(page),
            style: ElevatedButton.styleFrom(
              backgroundColor: page == currentPage ? Colors.orange : Colors.grey,
            ),
            child: Text(page.toString()),
          ),
        );
      }),
    );
  }
}
