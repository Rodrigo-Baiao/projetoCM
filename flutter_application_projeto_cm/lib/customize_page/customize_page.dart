// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/customize_page/custom_app_bar.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';
import 'package:provider/provider.dart';

class Customize extends StatelessWidget {
  const Customize({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      const Scaffold(
        body: GhostCustomizationPage(),
      
    );
  }
}

class GhostCustomizationPage extends StatefulWidget {
  const GhostCustomizationPage({super.key});

  @override
  _GhostCustomizationPageState createState() => _GhostCustomizationPageState();
}

class _GhostCustomizationPageState extends State<GhostCustomizationPage> {
  String _selectedImage = 'assets/colors/color_white.png';
  String _hatImage = '';
  List<Product> _purchasedProducts = [];

  void changeImage(String imagePath) {
    setState(() {
      _selectedImage = imagePath;
    });
  }

  void changeHat(String hatImage) {
    setState(() {
      _hatImage = hatImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ghostSettings = Provider.of<GhostSettings>(context);
    _purchasedProducts = ghostSettings.getPurchasedProducts();
    final hasItems = _purchasedProducts.isNotEmpty;
    final hatProducts = _purchasedProducts.where((product) => product.type == 'hat').toList();
    final colorProducts = _purchasedProducts.where((product) => product.type == 'color').toList();

    return Scaffold(
      appBar: CustomAppBar(
        
        onSavePressed: () async {
          ghostSettings.setGhostImage(_selectedImage);
          ghostSettings.setHatImage(_hatImage);
          await ghostSettings.saveSettings();
          Navigator.pop(context, {
            'selectedImage': _selectedImage,
            'hatImage': _hatImage,
          });
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'Customize your pet!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            hasItems
                ? SizedBox(
                    height: 500,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: 50,
                          child: Image.asset(
                            _selectedImage,
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
                  )
                : const Text(
                    'No items available',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
            const SizedBox(height: 20),
            if (hasItems)
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: hatProducts.map((product) {
                          return GestureDetector(
                            onTap: () {
                              changeHat(product.imageUrl);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: _hatImage == product.imageUrl
                                    ? Border.all(color: Colors.black, width: 2)
                                    : null,
                              ),
                              child: Image.asset(product.imageUrl),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            if (hasItems)
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: colorProducts.map((product) {
                          return GestureDetector(
                            onTap: () {
                              changeImage(product.imageUrl);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: _selectedImage == product.imageUrl
                                    ? Border.all(color: Colors.black, width: 2)
                                    : null,
                              ),
                              child: Image.asset(product.imageUrl),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
