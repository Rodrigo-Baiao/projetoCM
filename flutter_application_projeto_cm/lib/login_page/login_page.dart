import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/firebase_auth/auth.dart';
import 'package:flutter_application_projeto_cm/register_page/register_page.dart';
import 'package:flutter_application_projeto_cm/utils/show_snackbar.dart';

import 'fingerprint.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final int _lightBlue = 0xFFAFBFCF;
  final int _darkBlue = 0xFF043C71;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(_lightBlue),
      ),
      child: Scaffold(
        backgroundColor: Color(0xFFD1E3F8),
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 50),
            _inputField("Enter Username", usernameController),
            const SizedBox(height: 20),
            _inputField("Enter Password", passwordController, isPassword: true),
            const SizedBox(height: 30),
            _fingerprintIcon(),
            const SizedBox(height: 30),
            _logitBtn(),
            const SizedBox(height: 20),
            _createAcount(),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(_darkBlue), width: 3),
          shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Color(0xFF333333), size: 120),
    );
  }

  Widget _fingerprintIcon() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const FingerPrintSensorPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(_darkBlue), width: 3),
            shape: BoxShape.circle),
        child: const Icon(Icons.fingerprint, color: Color(0xFF333333), size: 80),
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Color(_darkBlue), width: 3),
    );

    return TextFormField(
      style: const TextStyle(color: Color(0xFF333333), fontSize: 18),
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF333333)),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
      validator: (value) {
        if (!isPassword) {
          if (value?.isEmpty ?? true) {
            return 'Introduza o seu e-mail';
          }
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!)) {
            return 'Introduza um e-mail válido';
          }
          return null;
        } else {
          if (value?.isEmpty ?? true) {
            return 'Introduza a sua palavra-passe';
          }
          return null;
        }
      },
    );
  }

  Widget _logitBtn() {
    return ElevatedButton(
      onPressed: () {
        /*
        debugPrint("Username: ${usernameController.text}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ProfileCustomizationScreen()));
        */
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
        } else {
          Auth().signInWithEmailAndPassword(
            email: usernameController.text,
            password: passwordController.text,
            context: context,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Color(_darkBlue),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAcount() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrationScreen()),
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
}
