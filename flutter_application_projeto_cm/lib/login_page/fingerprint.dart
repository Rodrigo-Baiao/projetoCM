import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

import '../profile_customize/custom_profile_page.dart';

class FingerPrintSensorPage extends StatefulWidget {
  const FingerPrintSensorPage({super.key});

  @override
  State<FingerPrintSensorPage> createState() => _FingerPrintSensorPageState();
}

class _FingerPrintSensorPageState extends State<FingerPrintSensorPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool? _isAuthenticated = false;

  Future<void> _localAuthenticate() async {
    try {
      _isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Necessário autenticação para acerder à aplicação',
      );

      setState(() {});
    } on PlatformException catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Ocorreu um erro ao tentar autenticar-se'),
            backgroundColor: Colors.red,
          ),
        );
    }
  }

  Widget _buildStatusTitle() {
    var title = "Pronto";
    var message = "Toque no botão para iniciar a autenticação";
    var icon = Icons.settings_power;
    var colorIcon = Colors.yellow;

    if (_isAuthenticated == true) {
      title = 'Ótimo';
      message = 'Verificação biométrica funcionou!!';
      icon = Icons.beenhere;
      colorIcon = Colors.green;
    } else if (_isAuthenticated == false) {
      /*
      title = 'Ops';
      message = 'Tente novamente!';
      icon = Icons.clear;
      colorIcon = Colors.red;
      */
      title = "Pronto";
      message = "Toque no botão para iniciar a autenticação";
      icon = Icons.settings_power;
      colorIcon = Colors.blue;
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      leading: Icon(
        icon,
        color: colorIcon,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 30),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autenticação Biométrica'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(16),
              child: _buildStatusTitle(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (!_isAuthenticated!) {
                  _localAuthenticate();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ProfileCustomizationScreen()),
                  );
                }
              },
              child: Text(_isAuthenticated! ? 'Ok' : 'Autenticar'),
            ),
          ],
        ),
      ),
    );
  }
}
