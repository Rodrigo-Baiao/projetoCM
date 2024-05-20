import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/customize_page/customize_page.dart';
import 'package:flutter_application_projeto_cm/minigames_page/minigamesMenu.dart';
import 'package:flutter_application_projeto_cm/settings_page/settings_page.dart';
import 'package:flutter_application_projeto_cm/shop_page/shop.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '300',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.monetization_on),
              ],
            ),
            IconButton(
              icon:const Icon(Icons.account_circle),
              onPressed: () {
                
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                    );
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Expanded(
            child: Center(
              child: Image.asset(
                "/colors/color_white.png",
  
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.brush),
                  iconSize: 50,
                  onPressed: () { 
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>const Customize()),
                    );
                  },
                ),
                IconButton(
                  icon:const Icon(Icons.videogame_asset),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MinigamesApp()),
                    );
                  },
                ),
                IconButton(
                  icon:const Icon(Icons.shop),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShopApp()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
