import 'dart:convert';
import 'package:employee_management_ad/auth/login_screen.dart';
import 'package:employee_management_ad/util/toaster.dart';
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
  bool _loading = false;

  Future<void> _signUp() async {
    setState(() {
      _loading = true;
    });

    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    // Replace the following placeholder code with your actual server endpoint and logic
    final String serverUrl =
        'https://employee-management-u6y6.onrender.com/app/admin/addAdmin';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
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
        showToast("Sign-up successful!", Colors.green);
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
        showToast(
          "Sign-up failed: ${response.reasonPhrase}",
          Colors.red,
        );
      }
    } catch (e) {
      print('Error during sign-up: $e');
      showToast(
        "Error during sign-up: $e",
        Colors.red,
      );
    } finally {
      setState(() {
        _loading = false;
      });
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
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          child: Column(
                            children: [
                              const Text(
                                "Sign - up",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              buildTextFieldWithIcon(
                                controller: firstNameController,
                                hintText: 'First Name',
                                icon: Icons.person_add,
                              ),
                              const SizedBox(height: 20),
                              buildTextFieldWithIcon(
                                controller: lastNameController,
                                hintText: 'Last Name',
                                icon: Icons.person,
                              ),
                              const SizedBox(height: 20),
                              buildTextFieldWithIcon(
                                controller: emailController,
                                hintText: 'Email',
                                icon: Icons.email,
                              ),
                              const SizedBox(height: 20),
                              buildTextFieldWithIcon(
                                controller: passwordController,
                                hintText: 'Password',
                                icon: Icons.lock,
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: size.width,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _loading ? null : _signUp,
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 61, 124, 251),
                                  ),
                                  child: _loading
                                      ? const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Color.fromARGB(255, 61, 124, 251),
                                          ),
                                        )
                                      : const Text(
                                          'Signup',
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
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 61, 124, 251),
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
          ),
        ),
      ),
    );
  }
}
