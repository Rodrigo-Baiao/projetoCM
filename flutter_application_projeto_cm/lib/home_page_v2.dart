import 'dart:async';
import 'dart:math';

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
import 'package:sensors_plus/sensors_plus.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPage> {
  bool isDusty1 = true;
  bool isDusty2 = true;
  bool isDusty3 = true;
  bool isDraggingShower = false;
  late DateTime lastInteractionTime;

  // Acelerometro Atributos
  final double _threshold = 15.0; 
  String displayImage = 'assets/sleeping.png';
  StreamSubscription<AccelerometerEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    final ghostSettings = Provider.of<GhostSettings>(context, listen: false);
    ghostSettings.setGhostImage('assets/sleeping.png');
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    _streamSubscription = SensorsPlatform.instance.accelerometerEvents
        .listen(_handleAccelerometerEvent);
    startDustResetTimer();
    lastInteractionTime = DateTime.now();
    startInactivityTimer();
  }

  void _handleAccelerometerEvent(AccelerometerEvent event) {
    double acceleration =
        sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
    if (acceleration > _threshold) {
      setState(() {
        final ghostSettings = Provider.of<GhostSettings>(context, listen: false);
        ghostSettings.setGhostImage('assets/ghost.png');
      });
      print("Device is shaking!");
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
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
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image(
                                  image: AssetImage('assets/coin.png'),
                                  width: 60,
                                  height: 60),
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
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileApp()));
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: GestureDetector(
                              child: Image(
                                  image: AssetImage('assets/settings_icon.png'),
                                  width: 45,
                                  height: 45),
                              onTap: () {
                                Sound.clickSound();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingsPage()));
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
                            child: Image(
                                image: AssetImage('assets/shop_icon.png'),
                                width: 70,
                                height: 70),
                            onTap: () {
                              Sound.clickSound();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ShopApp()));
                            },
                          ),
                          GestureDetector(
                            child: Image(
                                image: AssetImage('assets/map_icon.png'),
                                width: 120,
                                height: 120),
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
                                          image: AssetImage(
                                              lightSensor.windowImage),
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
                                  builder:
                                      (context, candidateData, rejectedData) {
                                    return Container(
                                      width: 350,
                                      height: 350,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              ghostSettings.ghostImage),
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
                                  child: Image(
                                      image: AssetImage(ghostSettings.hatImage),
                                      width: 240,
                                      height: 140,
                                      fit: BoxFit.contain),
                                ),
                              if (isDusty1)
                                Positioned(
                                  top: 100,
                                  left: 160,
                                  child: DragTarget<String>(
                                    onAccept: (data) {
                                      if (data == 'shower_icon') cleanDust1();
                                    },
                                    builder:
                                        (context, candidateData, rejectedData) {
                                      return Image.asset('assets/dust.png',
                                          width: 40, height: 40);
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
                                    builder:
                                        (context, candidateData, rejectedData) {
                                      return Image.asset('assets/dust.png',
                                          width: 40, height: 40);
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
                                    builder:
                                        (context, candidateData, rejectedData) {
                                      return Image.asset('assets/dust.png',
                                          width: 40, height: 40);
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
                                  feedback: Image(
                                      image: AssetImage(
                                          'assets/lollipop_icon.png')),
                                  childWhenDragging: Container(),
                                  child: Image(
                                      image: AssetImage(
                                          'assets/lollipop_icon.png')),
                                  onDragStarted: resetInactivityTimer,
                                  onDragEnd: (details) =>
                                      resetInactivityTimer(),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Draggable<String>(
                                  data: 'shower_icon',
                                  feedback: Image(
                                      image:
                                          AssetImage('assets/shower_icon.png')),
                                  childWhenDragging: Container(),
                                  child: Image(
                                      image:
                                          AssetImage('assets/shower_icon.png')),
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
                                child: Image(
                                    image: AssetImage(
                                        'assets/game_controller.png')),
                                onTap: () {
                                  Sound.clickSound();
                                  resetInactivityTimer();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MinigamesApp()));
                                },
                              ),
                              GestureDetector(
                                child: Image(
                                    image: AssetImage(
                                        'assets/customize_icon.png')),
                                onTap: () async {
                                  Sound.clickSound();
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Customize()));
                                  if (result != null) {
                                    ghostSettings
                                        .setGhostImage(result['selectedImage']);
                                    ghostSettings
                                        .setHatImage(result['hatImage']);
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
                    child:
                        MoneyAnimation(amount: ghostSettings.animationAmount),
                  ),
                if (ghostSettings.showFeedLimitMessage)
                  Positioned(
                    top: 200,
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    child: const FeedLimitAnimation(
                        phrase: "Não é possível alimentar mais"),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}