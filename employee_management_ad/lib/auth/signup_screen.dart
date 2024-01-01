import 'dart:convert';
import 'package:employee_management_ad/auth/login_screen.dart';
import 'package:employee_management_ad/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signUp() async {
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    // Replace the following placeholder code with your actual server endpoint and logic
    final String serverUrl = 'http://192.168.29.77:2000/app/admin/addAdmin';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'Authorization':
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im5rIiwidXNlclR5cGUiOiJlbXBsb3llZSIsImVtYWlsIjoibmtAZ21haWwuY29tIiwicGhvbmUiOjg4ODg2NzQ2NTAsImlhdCI6MTY5OTQ0NjIyOSwiZXhwIjoxNjk5NTMyNjI5fQ.KqkvY56rxPM9SxtahbaxXMvvFG6efStNfMk0A7gY_sc'
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(serverUrl),
        headers: headers,
        body: json.encode({
          "FirstName": firstName,
          "LastName": lastName,
          "Email": email,
          "Password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Sign-up successful');
        print(response.body);
        Fluttertoast.showToast(
          msg: "Sign-up successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
        // You can handle the response data here
      } else {
        print(
            'Sign-up failed: ${response.statusCode}, ${response.reasonPhrase}');
        print(response.body);
        Fluttertoast.showToast(
          msg: "Sign-up failed: ${response.reasonPhrase}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('Error during sign-up: $e');
      Fluttertoast.showToast(
        msg: "Error during sign-up: $e",
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Stack(
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
                child: SingleChildScrollView(
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: size.width / 3,
                      height: size.height,
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        child: Column(
                          children: [
                            Text(
                              "Sign - up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            buildTextFieldWithIcon(
                              controller: firstNameController,
                              hintText: 'First Name',
                              icon: Icons.person_add,
                            ),
                            SizedBox(height: 20),
                            buildTextFieldWithIcon(
                              controller: lastNameController,
                              hintText: 'Last Name',
                              icon: Icons.person,
                            ),
                            SizedBox(height: 20),
                            buildTextFieldWithIcon(
                              controller: emailController,
                              hintText: 'Email',
                              icon: Icons.email,
                            ),
                            SizedBox(height: 20),
                            buildTextFieldWithIcon(
                              controller: passwordController,
                              hintText: 'Password',
                              icon: Icons.lock,
                            ),
                            SizedBox(height: 40),
                            SizedBox(
                                width: size.width,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _signUp,
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 61, 124, 251),
                                  ),
                                  child: Text(
                                    'Signup',
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
                                  "Already have an account? ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Login',
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
            ),
          ],
        )),
      ),
    );
  }
}
