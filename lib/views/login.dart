import 'package:flutter/material.dart';
import 'package:wallet/resources/style_constants.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:developer' as developer;
import 'package:logging/logging.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final LocalAuthentication auth = LocalAuthentication();
  final usernameTextFieldController = TextEditingController();
  final passwordTextFieldController = TextEditingController();

  bool _authenticated = false;
  bool biometricsAuthenticationSupported = true;

  String _username = '';
  String _password = '';

  @override
  void dispose() {
    usernameTextFieldController.dispose();
    passwordTextFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    usernameTextFieldController.addListener(_setUsername);
    passwordTextFieldController.addListener(_setPassword);
    _authenticateWithBiometrics();
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: false,
          biometricOnly: false,
        ),
      );
      setState(() {
        _authenticated = authenticated;
      });
    } on Exception catch (e) {
      developer.log(e.toString(), level: Level.SEVERE.value);
      const SnackBar sb = SnackBar(
        content: Text("Biometrics credentials are NOT available."),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(sb);
      setState(() {
        biometricsAuthenticationSupported = false;
      });
      return;
    }
    if (!mounted) {
      return;
    }

    if (_authenticated) {
      Navigator.pushNamed(context, '/home');
    }
  }

  void _setUsername() {
    _username = usernameTextFieldController.text;
  }

  void _setPassword() {
    _password = passwordTextFieldController.text;
  }

  void processUsernamePassword() {
    if (_username != "admin" || _password != "admin") {
      const SnackBar sb = SnackBar(
        content: Text("Wrong Username/Password"),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(sb);
      return;
    }
    Navigator.pushNamed(context, '/home').then((value) {
      usernameTextFieldController.clear();
      passwordTextFieldController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: TextField(
                  controller: usernameTextFieldController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    icon: Icon(Icons.contact_mail),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: TextField(
                obscureText: true,
                controller: passwordTextFieldController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.password),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: verticalPadding),
              child: ElevatedButton(
                  onPressed: () => processUsernamePassword(),
                  child: const Text('Submit'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: verticalPadding),
              child: ElevatedButton(
                onPressed: biometricsAuthenticationSupported ? () => _authenticateWithBiometrics() : null,
                child: const Text('Use Biometrics'),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
