// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AuthorCreditsWidget extends StatefulWidget {
  const AuthorCreditsWidget({super.key});

  @override
  _AuthorCreditsWidgetState createState() => _AuthorCreditsWidgetState();
}

class _AuthorCreditsWidgetState extends State<AuthorCreditsWidget> {
  bool _showAuthorCredits = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.admin_panel_settings),
            const SizedBox(width: 8),
            const Text('Author Credits',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 20),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showAuthorCredits = !_showAuthorCredits;
                });
              },
              child: Icon(_showAuthorCredits ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
            ),
          ],
        ),
        if (_showAuthorCredits)
          Padding(
            padding: const EdgeInsets.only(left: 10), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var author in [
                  'Samuel Alves',
                  'Rodrigo Baião',
                  'Isidoro Ornelas',
                  'Miguel Pinto',
                  'André Castanho'
                ])
                  Padding(
                    padding: const EdgeInsets.only(left: 40), 
                    child: Text(author),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
