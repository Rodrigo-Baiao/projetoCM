import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSavePressed;

  const CustomAppBar({Key? key, required this.onSavePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
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
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: TextButton(
            onPressed: onSavePressed,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
