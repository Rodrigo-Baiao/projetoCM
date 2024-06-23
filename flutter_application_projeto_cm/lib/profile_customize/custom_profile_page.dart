import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';

class ProfileCustomizationScreen extends StatelessWidget {
  const ProfileCustomizationScreen({super.key});

  void _openDownloadsDirectory() async {
    final directoryPath = await getDirectoryPath();
    if (directoryPath != null) {
      // Handle the selected directory path
      print('Selected directory: $directoryPath');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Add your back button functionality here
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Customize your profile!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/src/assets/Profile_Ghost.png',
                    height: 70,
                  ),
                  const SizedBox(
                      width:
                          16), // Adjust the width between the image and avatar
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: IconButton(
                      icon: const Icon(
                        Icons.upload_rounded,
                        size: 30,
                        color: Colors.pink,
                      ),
                      onPressed: _openDownloadsDirectory,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Enter your first name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Enter your last name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                labelText: 'Enter your birthdate',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your next button functionality here
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: const Text('SAVE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: ProfileCustomizationScreen()));
