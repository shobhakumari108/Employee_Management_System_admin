import 'dart:convert';
import 'package:employee_management_ad/auth/signup_screen.dart';
import 'package:employee_management_ad/model/signup_model.dart';
import 'package:employee_management_ad/screen/home.dart';
import 'package:employee_management_ad/widgets/textfield.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization':
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbkRhdGEiOnsidXNlcm5hbWUiOiJwcmluY2UiLCJlbWFpbCI6InBrQGdtYWlsLmNvbSIsImlkIjoiNjU4YmUxZGYyYjUxOGQ1MTJiOGY4OTgxIiwiZmlyc3ROYW1lIjoicHJpbmNlIiwibGFzdE5hbWUiOiJrdW1hciJ9LCJpYXQiOjE3MDM2NjYyMzMsImV4cCI6MTcwNDA5ODIzM30.8sWSvSW-zf6SRmBC4z6sByLbPId4vMPUMrqkOr69y2E'
    };

    var request = http.Request(
        'POST', Uri.parse('http://192.168.29.135:2000/app/admin/login'));
    request.body = json.encode({
      "Email": _emailController.text,
      "Password": _passwordController.text,
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      // Read the response body once and store it in a variable
      String responseBody = await response.stream.bytesToString();

      // Print the status code and the entire response body for debugging
      print('Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful login
        Map<String, dynamic> responseData = json.decode(responseBody);
        Admin loggedInAdmin = Admin.fromJson(responseData['user']);
        String token = responseData['token'];
        print('Login successful. User: ${loggedInAdmin.toJson()}');
        print('Token: $token');
        Fluttertoast.showToast(
          msg: "Login successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );

        // TODO: Handle the successful login, such as navigating to the home screen
      } else {
        // Login failed
        print('Login failed. ${response.reasonPhrase}');
        Fluttertoast.showToast(
          msg: "Login failed: ${response.reasonPhrase}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('Error during login: $e');
      Fluttertoast.showToast(
        msg: "Error during login: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Container(
              height: size.height / 2,
              width: size.width,
              color: Color.fromARGB(255, 61, 124, 251),
              child: Padding(
                padding: const EdgeInsets.only(left: 250),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
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
              color: Colors.white, // Top half color
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Log - in",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      buildTextFieldWithIcon(
                        controller: _emailController,
                        hintText: 'Email',
                        icon: Icons.email,
                      ),
                      SizedBox(height: 20),
                      buildTextFieldWithIcon(
                        controller: _passwordController,
                        hintText: 'Password',
                        icon: Icons.lock,
                      ),
                      SizedBox(height: 60),
                      // ElevatedButton(
                      //   onPressed: _login,
                      //   child: Text('Login'),
                      // ),
                      SizedBox(
                          width: size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 61, 124, 251)),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don`t have an account? ",
                            style: TextStyle(fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the next page when the text is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SignupScreen()), // Replace NextPage() with your next page widget
                              );
                            },
                            child: Text(
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
      ]),
    );
  }
}
