import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/customize_page/customize_page.dart';
import 'package:flutter_application_projeto_cm/ghost/feed.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';
import 'package:flutter_application_projeto_cm/ghost/money.dart';
import 'package:flutter_application_projeto_cm/minigames_page/minigamesMenu.dart';
import 'package:flutter_application_projeto_cm/profile/profile.dart';
import 'package:flutter_application_projeto_cm/settings_page/settings_page.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound.dart';
import 'package:flutter_application_projeto_cm/shop_page/shop.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GhostSettings()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SafeArea(
        child: Consumer<GhostSettings>(
          builder: (context, ghostSettings, _) {
            double money = ghostSettings.money;

            Future.delayed(const Duration(minutes: 10), () {
              ghostSettings.resetFeedings();
            });

            return Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image(image: AssetImage('assets/coin.png'), width: 60, height: 60),
                              Text('$money'),
                            ],
                          ),
                          IconButton(
                            iconSize: 40,
                            icon: const Icon(Icons.person),
                            onPressed: () {
                              Sound.clickSound();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ProfileApp())
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: GestureDetector(
                              child: Image(image: AssetImage('assets/settings_icon.png'), width: 45, height: 45),
                              onTap: () {
                                Sound.clickSound();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SettingsPage())
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Image(image: AssetImage('assets/shop_icon.png'), width: 70, height: 70),
                            onTap: () {
                              Sound.clickSound();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ShopApp())
                              );
                            },
                          ),
                          GestureDetector(
                            child: Image(image: AssetImage('assets/map_icon.png'), width: 120, height: 120),
                            onTap: () {
                              Sound.clickSound();
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
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
                                      image: AssetImage('assets/windows/window1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 70,
                                child: DragTarget<String>(
                                  builder: (context, candidateData, rejectedData) {
                                    return Container(
                                      width: 350,
                                      height: 350,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(ghostSettings.ghostImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  onAcceptWithDetails: (details) {
                                    if (details.data == 'feed') {
                                      ghostSettings.feed();
                                    }
                                  },
                                ),
                              ),
                              if (ghostSettings.hatImage.isNotEmpty)
                                Positioned(
                                  top: 10,
                                  child: Image(image: AssetImage(ghostSettings.hatImage), width: 240, height: 140, fit: BoxFit.contain),
                                ),
                              Positioned(
                                top: 490,
                                left: 80,
                                child: MouseRegion(
                                  onEnter: (_) {
                                    // Implementar ação quando entrar na área de sujeira 1
                                  },
                                  child: Image(image: AssetImage('assets/dust.png'), width: 40, height: 40),
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
                                child: Draggable<String>(
                                  data: 'feed',
                                  feedback: Image(image: AssetImage('assets/lollipop_icon.png')),
                                  childWhenDragging: Container(),
                                  child: Image(image: AssetImage('assets/lollipop_icon.png')),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: GestureDetector(
                                  child: Image(image: AssetImage('assets/shower_icon.png')),
                                  onTap: () {
                                    Sound.clickSound();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: Image(image: AssetImage('assets/game_controller.png')),
                                onTap: () {
                                  Sound.clickSound();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const MinigamesApp())
                                  );
                                },
                              ),
                              GestureDetector(
                                child: Image(image: AssetImage('assets/customize_icon.png')),
                                onTap: () async {
                                  Sound.clickSound();
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Customize())
                                  );
                                  if (result != null) {
                                    ghostSettings.setGhostImage(result['selectedImage']);
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
                ),
                if (ghostSettings.showMoneyAnimation)
                  Positioned(
                    top: 200, 
                    left: MediaQuery.of(context).size.width / 2 - 30, 
                    child: MoneyAnimation(amount: ghostSettings.animationAmount),
                  ),
                if(ghostSettings.showFeedLimitMessage)
                  Positioned(
                    top: 200, 
                    left: MediaQuery.of(context).size.width / 2 - 30, 
                    child: const FeedLimitAnimation(phrase: "Não é possível alimentar mais"),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
