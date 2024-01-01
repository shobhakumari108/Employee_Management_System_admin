import 'dart:io';

import 'package:employee_management_ad/screen/home.dart';
import 'package:employee_management_ad/util/appbar.dart';
import 'package:employee_management_ad/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "Profile Screen"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 240, 239, 239),
                    radius: 50,
                    backgroundImage: _pickedImage != null
                        ? FileImage(File(_pickedImage!.path))
                        : null,
                    child: _pickedImage == null
                        ? Icon(
                            Icons.camera_alt,
                            size: 40,
                          )
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              // Text('First Name'),
              buildTextFieldWithIcon(
                controller: _firstNameController,
                hintText: 'First Name',
                icon: Icons.email,
              ),
              SizedBox(height: 20.0),
              // Text('Last Name'),
              buildTextFieldWithIcon(
                controller: _lastNameController,
                hintText: 'Last Name',
                icon: Icons.email,
              ),
              SizedBox(height: 20.0),
              // Text('Email'),
              buildTextFieldWithIcon(
                controller: _emailController,
                hintText: 'Email',
                icon: Icons.email,
              ),
              SizedBox(height: 20.0),
              // Text('Number'),
              buildTextFieldWithIcon(
                controller: _numberController,
                hintText: 'Number',
                icon: Icons.email,
              ),
              SizedBox(height: 20.0),
              // Text('Company Name'),
              buildTextFieldWithIcon(
                controller: _companyNameController,
                hintText: 'Company Name',
                icon: Icons.email,
              ),
              SizedBox(height: 40),

              SizedBox(
                  width: size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Access the entered values and picked image
                      String firstName = _firstNameController.text;
                      String lastName = _lastNameController.text;
                      String email = _emailController.text;
                      String number = _numberController.text;
                      String companyName = _companyNameController.text;

                      // Process the data as needed
                      print('First Name: $firstName');
                      print('Last Name: $lastName');
                      print('Email: $email');
                      print('Number: $number');
                      print('Company Name: $companyName');
                      if (_pickedImage != null) {
                        print('Image Path: ${_pickedImage!.path}');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 61, 124, 251),
                    ),
                    child: Text(
                      'Save',
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
        // Expanded(flex: 3, child: Container())
      ),
    );
  }
}
