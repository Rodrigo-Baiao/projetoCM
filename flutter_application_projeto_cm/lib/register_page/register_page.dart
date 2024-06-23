import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/utils/show_snackbar.dart';

import '../firebase_auth/auth.dart';
import '../login_page/login_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  Widget _pageHeader() {
    return Center(
      child: Column(
        children: [
          const Text(
            'Create your account',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            'and start playing!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/login.png', // Replace with your image asset
            height: 100,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInput(
      IconData icon, String hintTxt, TextEditingController controller,
      {isPassword = true}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon),
        hintText: hintTxt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      obscureText: isPassword,
    );
  }

  Widget _registerBtn() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (usernameController.text.isEmpty) {
            ShowSnackBar.showSnackbar(
              context: context,
              message: 'Por-favor preencha o campo Email.',
              backgroundColor: Theme.of(context).colorScheme.error,
            );
          } else if (passwordController.text.isEmpty) {
            ShowSnackBar.showSnackbar(
              context: context,
              message: 'Por-favor preencha o campo Password.',
              backgroundColor: Theme.of(context).colorScheme.error,
            );
          } else if (passwordController.text != confirmPassController.text) {
            ShowSnackBar.showSnackbar(
              context: context,
              message: 'As passwords não são iguais.',
              backgroundColor: Theme.of(context).colorScheme.error,
            );
          } else {
            Auth().createUserWithEmailAndPassword(
              email: usernameController.text,
              password: passwordController.text,
              context: context,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF002F6C), // Dark blue button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        ),
        child: const Text(
          'REGISTER',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _pageFooter() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        child: RichText(
          text: const TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: 'Log in',
                style: TextStyle(
                  color: Color(0xFF002F6C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD1E3F8), // Light blue background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // Handle back button press
                },
              ),
              const SizedBox(height: 20),
              _pageHeader(),
              _buildInput(Icons.email, 'Enter your email', usernameController,
                  isPassword: false),
              const SizedBox(height: 10),
              _buildInput(Icons.lock, 'Enter Password', passwordController),
              const SizedBox(height: 10),
              _buildInput(
                  Icons.lock, 'Confirm Password', confirmPassController),
              const SizedBox(height: 20),
              _registerBtn(),
              const Spacer(),
              _pageFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
