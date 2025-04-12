import 'package:flutter/material.dart';
import 'package:gps_tracker/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light, // Set to light mode
        useMaterial3: true,
      ),
      home: const LoginPage(), // Start with login
    );
  }
}
