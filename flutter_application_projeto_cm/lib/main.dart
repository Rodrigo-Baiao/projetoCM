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
            // Top section with currency, profile, and settings icons
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Image.asset('/coin.png', width: 50, height: 50),
                        ),
                        const Text('300'),
                      ],
                    ),
                    SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShopApp()));
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        child: Image.asset('/settings_icon.png', width: 30, height: 30),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 8, 50, 8), // Adiciona um pouco mais de preenchimento à esquerda
                      child: GestureDetector(
                        child: Image.asset('/shop_icon.png', width: 50, height: 50),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShopApp()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 30, 8), // Adiciona um pouco mais de preenchimento à direita
                      child: GestureDetector(
                        child: Image.asset('/map_icon.png', width: 100, height: 100),
                        onTap: () {
                          // Adicione aqui o comportamento desejado ao clicar no ícone de mapa
                        },
                      ),
                    ),
                  ],
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
                SizedBox(height: 10), // Adiciona um espaço entre as duas linhas de ícones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espaça uniformemente os ícones
                  children: [
                    GestureDetector(
                      child: Image.asset("/game_controller.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MinigamesApp()));
                      },
                    ),
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
