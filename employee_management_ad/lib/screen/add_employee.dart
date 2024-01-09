import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/service/Employee_service.dart';
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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        size: 50,
                        color: Color.fromARGB(255, 61, 124, 251),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: size.width * .5,
                  child: buildTextFieldWithIcon(
                    controller: _controllerFirstName,
                    hintText: 'First Name',
                    icon: Icons.person_add,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: size.width * .5,
                  child: buildTextFieldWithIcon(
                    controller: _controllerLastName,
                    hintText: 'Last Name',
                    icon: Icons.person,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: size.width * .5,
                  child: buildTextFieldWithIcon(
                    controller: _controllerEmail,
                    hintText: 'Email',
                    icon: Icons.email,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: size.width * .5,
                  child: buildTextFieldWithIcon(
                    controller: _controllerPassword,
                    hintText: 'Password',
                    icon: Icons.lock,
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: size.width / 3,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });

                            UserData user = UserData(
                              firstName: _controllerFirstName.text,
                              lastName: _controllerLastName.text,
                              email: _controllerEmail.text,
                              password: _controllerPassword.text,
                            );

                            // Add the employee using the EmployeeService
                            bool addEmployeeSuccess =
                                await EmployeeService.addEmployee(user);

                            setState(() {
                              _isLoading = false;
                            });

                            if (addEmployeeSuccess) {
                              // Handle success, e.g., show a success message or navigate to another screen
                              print("Employee added successfully");
                            } else {
                              // Handle failure, e.g., show an error message
                              print("Failed to add employee");
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(
                      //       10.0), // Adjust the radius as needed
                      // ),
                      primary: const Color.fromARGB(255, 61, 124, 251),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                        : Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
