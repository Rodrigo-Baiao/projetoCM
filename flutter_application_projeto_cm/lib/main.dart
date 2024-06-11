import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/customize_page/customize_page.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';
import 'package:flutter_application_projeto_cm/minigames_page/minigamesMenu.dart';
import 'package:flutter_application_projeto_cm/settings_page/settings_page.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound.dart';
import 'package:flutter_application_projeto_cm/shop_page/shop.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GhostSettings()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SafeArea(
        child: Consumer<GhostSettings>(
          builder: (context, ghostSettings, _) {
            double money = ghostSettings.money;

            return Column(
              children: [
                // Top part with money, person icon and settings icon
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('coin.png', width: 60, height: 60),
                          Text('$money'),
                        ],
                      ),
                      IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.person),
                        onPressed: () {
                          Sound.clickSound();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopApp()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: GestureDetector(
                          child: Image.asset('settings_icon.png',
                              width: 45, height: 45),
                          onTap: () {
                            Sound.clickSound();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child:
                            Image.asset('shop_icon.png', width: 70, height: 70),
                        onTap: () {
                          Sound.clickSound();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopApp()));
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('map_icon.png',
                            width: 120, height: 120),
                        onTap: () {
                          Sound.clickSound();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 450,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            top: 0,
                            right: 50,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/windows/window1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 70,
                            child: Container(
                              width: 350,
                              height: 350,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(ghostSettings.ghostImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          if (ghostSettings.hatImage.isNotEmpty)
                            Positioned(
                              top: 10,
                              child: Image.asset(
                                ghostSettings.hatImage,
                                width: 240,
                                height: 140,
                                fit: BoxFit.contain,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: GestureDetector(
                              child: Image.asset("lollipop_icon.png"),
                              onTap: () {
                                Sound.clickSound();
                              },
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                              child: Image.asset("shower_icon.png"),
                              onTap: () {
                            
                                Sound.clickSound();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: Image.asset("game_controller.png"),
                            onTap: () {
                              Sound.clickSound();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MinigamesApp()));
                            },
                          ),
                          GestureDetector(
                            child: Image.asset("customize_icon.png"),
                            onTap: () async {
                              Sound.clickSound();
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Customize()));
                              if (result != null) {
                                ghostSettings
                                    .setGhostImage(result['selectedImage']);
                                ghostSettings.setHatImage(result['hatImage']);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
