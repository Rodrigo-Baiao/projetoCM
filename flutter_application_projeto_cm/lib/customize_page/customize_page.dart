import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/customize_page/custom_app_bar.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';
import 'package:provider/provider.dart';


class Customize extends StatelessWidget {
  const Customize({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GhostSettings(), 
      child: Scaffold(
        appBar: CustomAppBar(
          onSavePressed: () {
        
          },
        ),
        body: GhostCustomizationPage(),
      ),
    );
  }
}


class GhostCustomizationPage extends StatefulWidget {
  const GhostCustomizationPage({Key? key});

  @override
  _GhostCustomizationPageState createState() => _GhostCustomizationPageState();
}

class _GhostCustomizationPageState extends State<GhostCustomizationPage> {
  String _ghostImage = '/colors/color_white.png';
  String _selectedImage = '/colors/color_white.png';
  String _hatImage = '';

  void changeImage(String imagePath) {
    setState(() {
      _ghostImage = imagePath;
      _selectedImage = imagePath;
    });
  }

  void changeHat(String hatImage) {
    setState(() {
      _hatImage = hatImage;
    });
  }

  void resetCustomization() {
    setState(() {
      _ghostImage = '/colors/color_white.png';
      _selectedImage = '/colors/color_white.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    final ghostSettings = Provider.of<GhostSettings>(context);
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
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
                    child: Image.asset(
                      _ghostImage,
                      width: 300,
                      height: 400,
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
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: resetCustomization,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: _selectedImage == '/colors/color_white.png'
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: Icon(
                        Icons.block,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeImage('/colors/color_blue.png');
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _selectedImage == '/colors/color_blue.png'
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: Image.asset('/colors/color_blue.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeImage('/colors/color_pink.png');
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _selectedImage == '/colors/color_pink.png'
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: Image.asset('/colors/color_pink.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeImage('colors/color_light_pink.png');
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _selectedImage == '/colors/color_light_pink.png'
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: Image.asset('/colors/color_light_pink.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeImage('/colors/color_yellow.png');
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _selectedImage == '/colors/color_yellow.png'
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: Image.asset('/colors/color_yellow.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeImage('/colors/color_green.png');
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _selectedImage == '/colors/color_green.png'
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: Image.asset('/colors/color_green.png'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
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
                      margin: EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        border: _hatImage.isEmpty
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: Center(
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
