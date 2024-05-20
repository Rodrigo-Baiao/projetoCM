// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PasswordChangeWidget extends StatefulWidget {
  const PasswordChangeWidget({super.key});

  @override
  _PasswordChangeWidgetState createState() => _PasswordChangeWidgetState();
}

class _PasswordChangeWidgetState extends State<PasswordChangeWidget> {
  bool _showPasswordFields = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.lock),
            const SizedBox(width: 8),
            const Text('Change Password',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 20),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showPasswordFields = !_showPasswordFields;
                });
              },
              child: Icon(_showPasswordFields ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
            ),
          ],
        ),
        if (_showPasswordFields)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 120),
                child: ListView(
                  padding: EdgeInsets.zero, 
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter Current Password',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter New Password',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
        
                  },
                  child:const Text('Confirm'),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
