import 'package:employee_management_ad/auth/signup_screen.dart';
import 'package:employee_management_ad/screen/home.dart';
import 'package:employee_management_ad/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() {
      _loading = true;
    });

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
          'https://employee-management-u6y6.onrender.com/app/admin/login'),
    );
    request.body = json.encode({
      "Email": _emailController.text,
      "Password": _passwordController.text,
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      print('Status Code: ${response.statusCode}');
      print('Reason Phrase: ${response.reasonPhrase}');

      String responseBody = await response.stream.bytesToString();
      print('Response Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Login successful!');
        print('Response Body: $responseBody');
        showToast("Login successful!", Colors.green);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        print('Login failed. ${response.reasonPhrase}');
        showToast('Login failed. ${response.reasonPhrase}', Colors.green);
      }
    } catch (e) {
      print('Error during login: $e');
      showToast(
        "Error during login: $e",
        Colors.red,
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: size.height / 2,
                width: size.width,
                color: Color.fromARGB(255, 61, 124, 251),
                child: Padding(
                  padding: const EdgeInsets.only(left: 250),
                  child: Row(
                    children: [
                      Lottie.asset(
                        'assets/Animation - 1703759522611.json',
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: size.height / 2,
                width: size.width,
                color: Colors.white,
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                right: 100,
                bottom: 50,
              ),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: size.height,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Log - in",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        buildTextFieldWithIcon(
                          controller: _emailController,
                          hintText: 'Email',
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          controller: _passwordController,
                          hintText: 'Password',
                          icon: Icons.lock,
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 61, 124, 251),
                            ),
                            child: _loading
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(255, 61, 124, 251),
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don`t have an account? ",
                              style: TextStyle(fontSize: 18),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Signup',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 61, 124, 251),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
