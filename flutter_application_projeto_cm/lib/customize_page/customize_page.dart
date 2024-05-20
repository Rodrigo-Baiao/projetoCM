import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/customize_page/custom_app_bar.dart';


class Customize extends StatelessWidget  {
  const Customize({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body:GhostCustomizationPage(),
    );
  }
}

class GhostCustomizationPage extends StatefulWidget {
  const GhostCustomizationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GhostCustomizationPageState createState() => _GhostCustomizationPageState();
}

class _GhostCustomizationPageState extends State<GhostCustomizationPage> {
  Color _ghostColor = Colors.transparent;
  Color _selectedColor = Colors.black;
  String _hatImage = ''; 

  void changeColor(Color color) {
    setState(() {
      _ghostColor = color;
      _selectedColor = color;
    });
  }

  void changeHat(String hatImage) {
    setState(() {
      _hatImage = hatImage;
    });
  }

  void resetCustomization() {
    setState(() {
      _ghostColor = Colors.transparent;
      _selectedColor = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Título
            Container(
              margin:const EdgeInsets.only(bottom: 20),
              child: const Text(
                'Customize your pet!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 500,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 50, 
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        _ghostColor,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        'assets/colors/color1.png',
                        width: 300,
                        height: 400,
                      ),
                    ),
                  ),
                  if (_hatImage.isNotEmpty)
                    Positioned(
                      top: 30, 
                      child: Image.asset(
                        _hatImage,
                        width: 240, 
                        height: 140, 
                        fit: BoxFit.contain,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  Colors.primaries.length + 1,
                  (index) {
                    if (index == Colors.primaries.length) {
                      return GestureDetector(
                        onTap: resetCustomization,
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
                            size: 20,
                          ),
                        ),
                      );
                    } else {
                      Color color = Colors.primaries[index];
                      return GestureDetector(
                        onTap: () {
                          changeColor(color);
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
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      changeHat('');
                    },
                    child: Container(
                      margin:const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        border: _hatImage.isEmpty
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeHat('assets/hats/hat1.png'); 
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _hatImage == 'assets/hats/hat1.png'
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/hats/hat1.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeHat('assets/hats/hat2.png');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _hatImage == 'assets/hats/hat2.png'
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/hats/hat2.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeHat('assets/hats/hat3.png');
                    },
                    child: Container(
                      margin:const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _hatImage == 'assets/hats/hat3.png'
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/hats/hat3.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
