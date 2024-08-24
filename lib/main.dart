import 'package:flutter/material.dart';
import 'package:wallet/views/home.dart';
import 'package:wallet/views/create_ia.dart';
import 'package:wallet/views/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: Colors.blue),
          useMaterial3: true
        /* dark theme settings */
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext ctx) => const LoginPage(title: 'Login'),
        '/home': (BuildContext ctx) => const HomePage(title: 'Home'),
        '/create_ia': (BuildContext ctx) => const CreateIAPage(title: 'Create IA')
      },
    );
  }
}