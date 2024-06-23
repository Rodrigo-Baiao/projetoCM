import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound.dart';
import 'package:flutter_application_projeto_cm/ghost/money.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';

class CleaningMinigame extends StatefulWidget {
  const CleaningMinigame({super.key});

  @override
  _CleaningMinigameState createState() => _CleaningMinigameState();
}

class _CleaningMinigameState extends State<CleaningMinigame> {
  bool isDusty1 = true;
  bool isDusty2 = true;
  bool isDusty3 = true;
  bool isDusty4 = true;
  bool isCobwebbed1 = true;
  bool isCobwebbed2 = true;
  bool isCobwebbed3 = true;
  bool isCobwebbed4 = true;
  bool isDraggingTool1 = false;
  bool isDraggingTool2 = false;
  bool showMoneyAnimation = false;

  void cleanDust1() {
    setState(() {
      isDusty1 = false;
      checkAllCleaned();
    });
  }

  void cleanDust2() {
    setState(() {
      isDusty2 = false;
      checkAllCleaned();
    });
  }

  void cleanDust3() {
    setState(() {
      isDusty3 = false;
      checkAllCleaned();
    });
  }

  void cleanDust4() {
    setState(() {
      isDusty4 = false;
      checkAllCleaned();
    });
  }

  void cleanCobweb1() {
    setState(() {
      isCobwebbed1 = false;
      checkAllCleaned();
    });
  }

  void cleanCobweb2() {
    setState(() {
      isCobwebbed2 = false;
      checkAllCleaned();
    });
  }

  void cleanCobweb3() {
    setState(() {
      isCobwebbed3 = false;
      checkAllCleaned();
    });
  }

  void cleanCobweb4() {
    setState(() {
      isCobwebbed4 = false;
      checkAllCleaned();
    });
  }

  void checkAllCleaned() {
    if (!isDusty1 && !isDusty2 && !isDusty3 && !isDusty4 &&
        !isCobwebbed1 && !isCobwebbed2 && !isCobwebbed3 && !isCobwebbed4) {
      final ghostSettings = Provider.of<GhostSettings>(context, listen: false);
      ghostSettings.addMoney(10);
      setState(() {
        showMoneyAnimation = true;
        Sound.playLevelpassed();
      });
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            showMoneyAnimation = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spook's House"),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/spooky_haunted_house.png', // Use the new image
              fit: BoxFit.cover,
            ),
          ),
          if (isDusty1)
            Positioned(
              top: 490,
              left: 80,
              child: DragTarget<String>(
                onAccept: (data) {
                  if (data == 'cleaning_tool_1') cleanDust1();
                },
                builder: (context, candidateData, rejectedData) {
                  return Image.asset('assets/dust.png', width: 40, height: 40);
                },
              ),
            ),
          if (isDusty2)
            Positioned(
              top: 480,
              left: 180,
              child: DragTarget<String>(
                onAccept: (data) {
                  if (data == 'cleaning_tool_1') cleanDust2();
                },
                builder: (context, candidateData, rejectedData) {
                  return Image.asset('assets/dust.png', width: 40, height: 40);
                },
              ),
            ),
          if (isDusty3)
            Positioned(
              top: 500,
              left: 280,
              child: DragTarget<String>(
                onAccept: (data) {
                  if (data == 'cleaning_tool_1') cleanDust3();
                },
                builder: (context, candidateData, rejectedData) {
                  return Image.asset('assets/dust.png', width: 40, height: 40);
                },
              ),
            ),
          if (isDusty4)
            Positioned(
              top: 480,
              left: 380,
              child: DragTarget<String>(
                onAccept: (data) {
                  if (data == 'cleaning_tool_1') cleanDust4();
                },
                builder: (context, candidateData, rejectedData) {
                  return Image.asset('assets/dust.png', width: 40, height: 40);
                },
              ),
            ),
          if (isCobwebbed1)
            Positioned(
              top: 400,
              left: 200,
              child: DragTarget<String>(
                onAccept: (data) {
                  if (data == 'cleaning_tool_2') cleanCobweb1();
                },
                builder: (context, candidateData, rejectedData) {
                  return Image.asset('assets/cobweb.png', width: 40, height: 40);
                },
              ),
            ),
          if (isCobwebbed2)
            Positioned(
              top: 300,
              left: 350,
              child: DragTarget<String>(
                onAccept: (data) {
                  if (data == 'cleaning_tool_2') cleanCobweb2();
                },
                builder: (context, candidateData, rejectedData) {
                  return Image.asset('assets/cobweb.png', width: 40, height: 40);
                },
              ),
            ),
          if (isCobwebbed3)
            Positioned(
              top: 250,
              left: 250,
              child: DragTarget<String>(
                onAccept: (data) {
                  if (data == 'cleaning_tool_2') cleanCobweb3();
                },
                builder: (context, candidateData, rejectedData) {
                  return Image.asset('assets/cobweb.png', width: 40, height: 40);
                },
              ),
            ),
          if (isCobwebbed4)
            Positioned(
              top: 350,
              left: 150,
              child: DragTarget<String>(
                onAccept: (data) {
                  if (data == 'cleaning_tool_2') cleanCobweb4();
                },
                builder: (context, candidateData, rejectedData) {
                  return Image.asset('assets/cobweb.png', width: 40, height: 40);
                },
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Draggable<String>(
                    data: 'cleaning_tool_1',
                    onDragStarted: () {
                      setState(() {
                        isDraggingTool1 = true;
                      });
                    },
                    onDraggableCanceled: (_, __) {
                      setState(() {
                        isDraggingTool1 = false;
                      });
                    },
                    onDragEnd: (_) {
                      setState(() {
                        isDraggingTool1 = false;
                      });
                    },
                    feedback: Image.asset('assets/cleaning_tool_1.png', width: 50, height: 50),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: Image.asset('assets/cleaning_tool_1.png', width: 50, height: 50),
                    ),
                    child: Image.asset('assets/cleaning_tool_1.png', width: 50, height: 50),
                  ),
                  const SizedBox(width: 20),
                  Draggable<String>(
                    data: 'cleaning_tool_2',
                    onDragStarted: () {
                      setState(() {
                        isDraggingTool2 = true;
                      });
                    },
                    onDraggableCanceled: (_, __) {
                      setState(() {
                        isDraggingTool2 = false;
                      });
                    },
                    onDragEnd: (_) {
                      setState(() {
                        isDraggingTool2 = false;
                      });
                    },
                    feedback: Image.asset('assets/cleaning_tool_2.png', width: 50, height: 50),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: Image.asset('assets/cleaning_tool_2.png', width: 50, height: 50),
                    ),
                    child: Image.asset('assets/cleaning_tool_2.png', width: 50, height: 50),
                  ),
                ],
              ),
            ),
          ),
          if (showMoneyAnimation)
            const Positioned(
              top: 200,
              left: 100,
              child: MoneyAnimation(amount: 10),
            ),
        ],
      ),
    );
  }
}
