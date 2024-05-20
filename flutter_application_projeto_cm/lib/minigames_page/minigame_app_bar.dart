import 'package:flutter/material.dart';

class MinigameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MinigameAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Back',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          const Text('MiniGames'),
          const Spacer(flex: 2),  // Adjust flex to balance the layout
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
