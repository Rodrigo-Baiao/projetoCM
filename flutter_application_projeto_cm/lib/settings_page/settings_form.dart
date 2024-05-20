// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_projeto_cm/settings_page/authors_credits.dart';
import 'package:flutter_application_projeto_cm/settings_page/change_password.dart';
import 'package:flutter_application_projeto_cm/settings_page/fingerprint.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound_and_notifications.dart';
import 'package:flutter_application_projeto_cm/settings_page/support_and_feedback.dart';


class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 56.0),
            child: SoundNotificationSwitches(),
          ),
          SizedBox(height: 60),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: PasswordChangeWidget(),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: FingerprintWidget(),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: SupportFeedbackWidget(),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: AuthorCreditsWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
