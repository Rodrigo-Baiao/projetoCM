import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/settings_page/appbar.dart';


import 'divider.dart';
import 'settings_form.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyDivider(),
            SettingsForm(),
          ],
        ),
      ),
    );
  }
}
