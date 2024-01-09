import 'package:employee_management_ad/auth/login_screen.dart';
import 'package:employee_management_ad/auth/signup_screen.dart';
import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/provider/userProvider.dart';
import 'package:employee_management_ad/screen/home.dart';
import 'package:employee_management_ad/screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
        home: HomeScreen()
        // home: TaskScreen(employee: UserData()),
        );
  }
}
