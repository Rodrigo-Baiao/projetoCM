import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/customize_page/customize_page.dart';
import 'package:flutter_application_projeto_cm/minigames_page/minigamesMenu.dart';
import 'package:flutter_application_projeto_cm/settings_page/settings_page.dart';
import 'package:flutter_application_projeto_cm/shop_page/shop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top row with icons and currency
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.store),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopApp()));
                  },
                ),
                Row(
                  children: [
                    Icon(Icons.monetization_on),
                    Text('300'),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  },
                ),
              ],
            ),
            // Middle part with ghost and window
            Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: -100,
                      left: 120,
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/windows/window1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('colors/color_white.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Bottom part with various icons
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: GestureDetector(
                        child: Image.asset("/lollipop_icon.png"),
                        onTap: () {
                          // Adicione aqui o comportamento desejado ao clicar no pirulito
                        },
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        child: Image.asset("/shower_icon.png"),
                        onTap: () {
                          // Adicione aqui o comportamento desejado ao clicar no chuveiro
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Image.asset("/game_controller.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MinigamesApp()));
                      },
                    ),
                    SizedBox(width: 40), // Ajusta a distância entre os ícones
                    GestureDetector(
                      child: Image.asset("/customize_icon.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Customize()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
