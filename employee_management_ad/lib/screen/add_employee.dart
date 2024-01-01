import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/screen/employee_list.dart';
import 'package:employee_management_ad/screen/home.dart';
import 'package:employee_management_ad/service/Employee_service.dart';
import 'package:employee_management_ad/util/appbar.dart';
import 'package:employee_management_ad/widgets/textfield.dart';
import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "Edit Employee"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: Material(
                      borderRadius: BorderRadius.circular(60),
                      elevation: 10,
                      child: Icon(
                        Icons.person,
                        size: 50, // Adjust the icon size as needed
                        color: Color.fromARGB(
                            255, 61, 124, 251), // Set the icon color as needed
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                buildTextFieldWithIcon(
                  controller: _controllerFirstName,
                  hintText: 'First Name',
                  icon: Icons.person_add,
                ),
                SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _controllerLastName,
                  hintText: 'Last Name',
                  icon: Icons.person,
                ),
                SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _controllerEmail,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                SizedBox(height: 20),
                buildTextFieldWithIcon(
                  controller: _controllerPassword,
                  hintText: 'Password',
                  icon: Icons.lock,
                ),
                SizedBox(height: 40),
                SizedBox(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        UserData user = UserData(
                          firstName: _controllerFirstName.text,
                          lastName: _controllerLastName.text,
                          email: _controllerEmail.text,
                          password: _controllerPassword.text,
                        );

                        // print("User Data: ${user.toJson()}");

                        // Call the ApiService to sign up the user
                        bool signUpSuccess =
                            await EmployeeService.addEmployee(user);

                        // if (signUpSuccess) {
                        //   // Navigate to the login screen
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => EmployeeListScreen()),
                        //   );
                        //   print("==================================");
                        // } else {
                        //   // Handle sign-up failure
                        //   print("Sign-up failed");
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 61, 124, 251),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
