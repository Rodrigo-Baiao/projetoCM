import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/main.dart';
import 'package:flutter_application_projeto_cm/utils/show_snackbar.dart';

import '../login_page/login_page.dart';
import '../profile_customize/custom_profile_page.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  void updateUserInfo(String name, String lastName, String photo) {
    String username = "$name $lastName";
    currentUser!.updateProfile(displayName: username, photoURL: photo);
    String? aux1 = currentUser!.displayName;
    print("Updated user info: $aux1");
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      print("Error code = " + e.code);
      if (e.code == 'invalid-credential') {
        ShowSnackBar.showSnackbar(
          context: context,
          message: 'Email ou Password incorretos.',
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      } else if (e.code == 'invalid-email') {
        ShowSnackBar.showSnackbar(
          context: context,
          message: 'Email invalido..',
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));

      ShowSnackBar.showSnackbar(
          context: context,
          message: 'Utilizador registado com sucesso.',
          backgroundColor: Colors.green);

      print('Utilizador registado com sucesso.');
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        ShowSnackBar.showSnackbar(
          context: context,
          message: 'Este utilizador já se encontra registado no sistema.',
          backgroundColor: Theme.of(context).colorScheme.error,
        );

        //print('Este utilizador já se encontra registado no sistema.');
      } else if (e.code == 'weak-password') {
        ShowSnackBar.showSnackbar(
          context: context,
          message: 'A password tem que conter pelo menos 6 caracteres.',
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
