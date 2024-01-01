import 'package:employee_management_ad/auth/login_screen.dart';
import 'package:employee_management_ad/auth/signup_screen.dart';
import 'package:employee_management_ad/screen/home.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: HomeScreen(),
        // home: SignupScreen(),
        // home: LoginScreen(),
        home: HomeScreen());
  }
}
