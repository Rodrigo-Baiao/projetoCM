import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            icon:const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Text(
            'Back',
            style: TextStyle(fontSize: 12),
          ),
          const Spacer(),
          const Text(
            'Settings',
            style: TextStyle(fontSize: 20),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  // ignore: prefer_const_constructors
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
