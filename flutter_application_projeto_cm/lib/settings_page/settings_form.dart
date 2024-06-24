import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/firebase_auth/auth.dart';
import 'package:flutter_application_projeto_cm/settings_page/authors_credits.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound_switch.dart';
import 'package:flutter_application_projeto_cm/settings_page/support_and_feedback.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  Widget logoutBtn() {
    return TextButton(
      onPressed: () {
        Auth().signOut(context);
      },
      child: const Text(
        'Sign Out',
        style: TextStyle(
          color: Colors.red,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SoundSwitch(),
          const SizedBox(height: 40),
          const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: SupportFeedbackWidget(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: AuthorCreditsWidget(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: logoutBtn(), // Correctly reference the logout button
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
