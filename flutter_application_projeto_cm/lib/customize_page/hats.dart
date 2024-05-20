// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class HatSelectorWidget extends StatefulWidget {
  const HatSelectorWidget({super.key});

  @override
  _HatSelectorWidgetState createState() => _HatSelectorWidgetState();
}

class _HatSelectorWidgetState extends State<HatSelectorWidget> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = const Color.fromARGB(0, 0, 0, 0);
  }

  void _setColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            _selectedColor,
            BlendMode.srcIn,
          ),
         
          
        ),
       
        // Paleta de cores deslizável
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