import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';
import 'package:flutter_application_projeto_cm/profile/profile_app_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: AchievementsPage(),
    );
  }
}

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Consumer<GhostSettings>(
            builder: (context, ghostSettings, _) {
              return CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Image.asset(ghostSettings.ghostImage, height: 60),
              );
            },
          ),
          SizedBox(height: 10),
          Text(
            'Spook',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<GhostSettings>(
              builder: (context, ghostSettings, _) {
                double money = ghostSettings.money;
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(29, 187, 222, 251),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/coin.png', width: 40, height: 40),
                      SizedBox(width: 10),
                      Text('$money', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



