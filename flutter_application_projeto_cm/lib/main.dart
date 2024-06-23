import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_application_projeto_cm/customize_page/customize_page.dart';
import 'package:flutter_application_projeto_cm/ghost/feed.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';
import 'package:flutter_application_projeto_cm/ghost/money.dart';
import 'package:flutter_application_projeto_cm/light_sensor.dart';
import 'package:flutter_application_projeto_cm/minigames_page/minigamesMenu.dart';
import 'package:flutter_application_projeto_cm/profile/profile.dart';
import 'package:flutter_application_projeto_cm/settings_page/settings_page.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound.dart';
import 'package:flutter_application_projeto_cm/shop_page/shop.dart';
import 'package:provider/provider.dart';

void main() {
  AwesomeNotifications().initialize(
    null, 
    [
      NotificationChannel(
        channelKey: 'Basic_Channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
      ),
    ],
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GhostSettings()),
          ChangeNotifierProvider(create: (_) => LightSensorr()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Splash(),
        ),
      );
    } catch (e) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Erro ao iniciar o aplicativo'),
          ),
        ),
      );
    }
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(26.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    backgroundColor: Colors.white,
                    minHeight: 20.0,
                  ),
                ),
              ),
              SizedBox(height: 200), // Add some space between the progress bar and the bottom of the screen
            ],
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDusty1 = true;
  bool isDusty2 = true;
  bool isDusty3 = true;
  bool isDraggingShower = false;
  late DateTime lastInteractionTime;

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
    startDustResetTimer();
    lastInteractionTime = DateTime.now();
    startInactivityTimer();
  }

  void startDustResetTimer() {
    Future.delayed(const Duration(minutes: 2), () {
      setState(() {
        isDusty1 = true;
        isDusty2 = true;
        isDusty3 = true;
      });
      startDustResetTimer();
    });
  }

  void cleanDust1() {
    setState(() {
      isDusty1 = false;
      checkAllCleaned();
      resetInactivityTimer();
    });
  }

  void cleanDust2() {
    setState(() {
      isDusty2 = false;
      checkAllCleaned();
      resetInactivityTimer();
    });
  }

  void cleanDust3() {
    setState(() {
      isDusty3 = false;
      checkAllCleaned();
      resetInactivityTimer();
    });
  }

  void checkAllCleaned() {
    if (!isDusty1 && !isDusty2 && !isDusty3) {
      final ghostSettings = Provider.of<GhostSettings>(context, listen: false);
      ghostSettings.addMoney(30);
      setState(() {
        ghostSettings.showMoneyAnimation = true;
        Sound.playLevelpassed();
      });
    }
  }

  void startInactivityTimer() {
    Future.delayed(const Duration(minutes: 1), () {
      if (DateTime.now().difference(lastInteractionTime).inMinutes >= 1) {
        sendInactivityNotification();
      }
      startInactivityTimer();
    });
  }

  void resetInactivityTimer() {
    setState(() {
      lastInteractionTime = DateTime.now();
    });
  }

  void sendInactivityNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'Basic_Channel',
        title: 'Spook está com saudades suas!',
        body: 'Venha cuidar do seu amigo fantasma!',
      ),
    );
  }

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
                                child: Consumer<LightSensorr>(
                                  builder: (context, lightSensor, _) {
                                    return Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(lightSensor.windowImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
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
                              if (isDusty1)
                                Positioned(
                                  top: 100,
                                  left: 160,
                                  child: DragTarget<String>(
                                    onAccept: (data) {
                                      if (data == 'shower_icon') cleanDust1();
                                    },
                                    builder: (context, candidateData, rejectedData) {
                                      return Image.asset('assets/dust.png', width: 40, height: 40);
                                    },
                                  ),
                                ),
                              if (isDusty2)
                                Positioned(
                                  top: 230,
                                  left: 290,
                                  child: DragTarget<String>(
                                    onAccept: (data) {
                                      if (data == 'shower_icon') cleanDust2();
                                    },
                                    builder: (context, candidateData, rejectedData) {
                                      return Image.asset('assets/dust.png', width: 40, height: 40);
                                    },
                                  ),
                                ),
                              if (isDusty3)
                                Positioned(
                                  top: 300,
                                  left: 180,
                                  child: DragTarget<String>(
                                    onAccept: (data) {
                                      if (data == 'shower_icon') cleanDust3();
                                    },
                                    builder: (context, candidateData, rejectedData) {
                                      return Image.asset('assets/dust.png', width: 40, height: 40);
                                    },
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
                                  onDragStarted: resetInactivityTimer,
                                  onDragEnd: (details) => resetInactivityTimer(),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Draggable<String>(
                                  data: 'shower_icon',
                                  feedback: Image(image: AssetImage('assets/shower_icon.png')),
                                  childWhenDragging: Container(),
                                  child: Image(image: AssetImage('assets/shower_icon.png')),
                                  onDragStarted: () {
                                    setState(() {
                                      isDraggingShower = true;
                                    });
                                    resetInactivityTimer();
                                  },
                                  onDraggableCanceled: (_, __) {
                                    setState(() {
                                      isDraggingShower = false;
                                    });
                                    resetInactivityTimer();
                                  },
                                  onDragEnd: (details) {
                                    setState(() {
                                      isDraggingShower = false;
                                    });
                                    resetInactivityTimer();
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
                                  resetInactivityTimer();
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
                                  resetInactivityTimer();
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
                if (ghostSettings.showFeedLimitMessage)
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
