// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({super.key});

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late Color _selectedColor;


  void _setColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Image.asset(
            'assets/images/ghost.png',
            width: 300,
            height: 400,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              Colors.primaries.length + 1, 
              (index) {
                if (index == Colors.primaries.length) {
                  return GestureDetector(
                    onTap: () {
                      _setColor(const Color.fromARGB(0, 0, 0, 0));
                    },
                    child: Container(
                      margin:const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: _selectedColor == Colors.white
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child:const Icon(
                        Icons.block,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                  );
                } else {
                  Color color = Colors.primaries[index];
                  return GestureDetector(
                    onTap: () {
                      _setColor(color);
                    },
                    child: Container(
                      margin:const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: _selectedColor == color
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
}
}