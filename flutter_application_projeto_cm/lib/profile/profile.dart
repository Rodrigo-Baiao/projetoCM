import 'package:flutter/material.dart';
import "package:flutter_application_projeto_cm/ghost/ghost.dart";
import 'package:flutter_application_projeto_cm/profile/profile_app_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ProfileAppBar(),
      body: AchievementsPage(),
    );
  }
}

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ghostSettings = Provider.of<GhostSettings>(context);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            
            child: Image.asset(ghostSettings.ghostImage, height: 60), 
          ),
          const SizedBox(height: 10),
          const Text(
            'Spook',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Achievements',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const AchievementCard(
                  icon: Icons.emoji_events,
                  text: '1 week streak!',
                ),
                const AchievementCard(
                  icon: Icons.cleaning_services,
                  text: 'House cleaned',
                ),
                const AchievementCard(
                  icon: Icons.play_arrow,
                  text: '1 month played',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const AchievementCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
        ),
        title: Text(text),
      ),
    );
  }
}
