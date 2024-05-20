import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Divider(
          color: Colors.black,
          thickness: 1,
          height: 1,
        ),
      ),
    );
  }
}
