import 'package:flutter/material.dart';

class QuizGameAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackClicked;

  const QuizGameAppBar({super.key, required this.onBackClicked});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              onBackClicked();
              Navigator.pop(context);
            },
          ),
          const Text(
            'Back',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
