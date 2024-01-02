// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/provider/userProvider.dart';
import 'package:employee_management_ad/screen/employee_profile_screen.dart';
import 'package:employee_management_ad/screen/home.dart';
import 'package:employee_management_ad/service/Employee_service.dart';
import 'package:employee_management_ad/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class EmployeeEditScreen extends StatefulWidget {
  final UserData employee;

  const EmployeeEditScreen({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  _EmployeeEditScreenState createState() => _EmployeeEditScreenState();
}

class _EmployeeEditScreenState extends State<EmployeeEditScreen> {
//  late UserData userData;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     userData = Provider.of<UserProvider>(context).userInformation;
//   }

  bool _isUpdating = false;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _jobTypeController = TextEditingController();
  TextEditingController _joiningDateController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _educationController = TextEditingController();
  TextEditingController _employmentStatusController = TextEditingController();
  TextEditingController _workScheduleController = TextEditingController();
  TextEditingController _companyEmployeeIDController = TextEditingController();
  TextEditingController _managerIDController = TextEditingController();

  String? _selectedPhoto; // Added variable for the selected photo

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with existing values
    _firstNameController.text = widget.employee.firstName ?? '';
    _lastNameController.text = widget.employee.lastName ?? '';
    _emailController.text = widget.employee.email ?? '';
    _phoneController.text = widget.employee.mobileNumber ?? '';
    _jobTypeController.text = widget.employee.jobTitle ?? '';
    // _joiningDateController.text = widget.employee.joiningDate ?? '';
    _companyNameController.text = widget.employee.companyName ?? '';
    _addressController.text = widget.employee.address ?? '';
    _departmentController.text = widget.employee.department ?? '';
    _educationController.text = widget.employee.education ?? '';
    _employmentStatusController.text = widget.employee.employmentStatus ?? '';
    _workScheduleController.text = widget.employee.workSchedule ?? '';
    _companyEmployeeIDController.text = widget.employee.companyEmployeeID ?? '';
    _managerIDController.text = widget.employee.managerID ?? '';

    // Set the selected photo
    _selectedPhoto = widget.employee.profilePhoto;
  }

  Future<void> _updateEmployeeProfile() async {
    setState(() {
      _isUpdating = true; // Set _isUpdating to true when starting the update
    });
    // Create an Employee object with updated values
    UserData updatedEmployee = UserData(
      sId: widget.employee.sId,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      mobileNumber: _phoneController.text,
      jobTitle: _jobTypeController.text,
      // joiningDate: _joiningDateController.text,
      companyName: _companyNameController.text,
      address: _addressController.text,
      department: _departmentController.text,
      education: _educationController.text,
      employmentStatus: _employmentStatusController.text,
      workSchedule: _workScheduleController.text,
      companyEmployeeID: _companyEmployeeIDController.text,
      managerID: _managerIDController.text,
      profilePhoto: _selectedPhoto ?? widget.employee.profilePhoto,
    );
    print(
        "====================================================${updatedEmployee}");
    // Call the service to update the employee
    bool success = await EmployeeService.updateEmployee(updatedEmployee);
    setState(() {
      _isUpdating =
          false; // Set _isUpdating to false when the update is complete
    });

    if (success) {
      // Show a toast and return the updated employee data
      Fluttertoast.showToast(msg: 'Profile updated');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeProfileScreen(
            employee: updatedEmployee,
          ),
        ),
        (route) => false,
      );
    } else {
      Fluttertoast.showToast(msg: 'Failed to update profile');
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _joiningDateController.text = _selectedDate.toIso8601String();
      });
    }
  }

  // Function to pick an image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        // Crop the selected image
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path!,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
        );

        if (croppedFile != null) {
          setState(() {
            _selectedPhoto = croppedFile.path;
          });
        }
      }
    } on Exception catch (e) {
      // Handle exceptions, e.g., if the user denies camera or gallery access
      print('Error picking image: $e');
      Fluttertoast.showToast(msg: 'Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Card(
        child: Scaffold(
          // appBar: buildAppBar(context, "Edit Employee"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo selection
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Take a photo'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text('Choose from gallery'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.gallery);
                                },
                              ),
                              if (_selectedPhoto != null &&
                                  _selectedPhoto!.isNotEmpty)
                                ListTile(
                                  leading: const Icon(Icons.delete),
                                  title: const Text('Remove photo'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      _selectedPhoto = null;
                                    });
                                  },
                                ),
                            ],
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(60),
                            image: _selectedPhoto != null &&
                                    _selectedPhoto!.isNotEmpty
                                ? DecorationImage(
                                    image: FileImage(File(_selectedPhoto!)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child:
                              _selectedPhoto == null || _selectedPhoto!.isEmpty
                                  ? Center(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                        color: Colors.grey[600],
                                      ),
                                    )
                                  : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Other text fields

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "First name",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildTextFieldWithIcon(
                              controller: _firstNameController,
                              hintText: 'First name',
                              icon: Icons.person,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Last Name",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildTextFieldWithIcon(
                              controller: _lastNameController,
                              hintText: 'Last name',
                              icon: Icons.person,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // const SizedBox(height: 20),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildTextFieldWithIcon(
                              controller: _emailController,
                              hintText: 'Email',
                              icon: Icons.email,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Phone number",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildTextFieldWithIcon(
                              controller: _phoneController,
                              hintText: 'Phone number',
                              icon: Icons.phone,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Job type",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildTextFieldWithIcon(
                              controller: _jobTypeController,
                              hintText: 'job type',
                              icon: Icons.work,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Company name",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildTextFieldWithIcon(
                              controller: _companyNameController,
                              hintText: ' Company name',
                              icon: Icons.work,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //===========================
                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    "Address",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTextFieldWithIcon(
                    controller: _addressController,
                    hintText: 'Address',
                    icon: Icons.work,
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Department",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTextFieldWithIcon(
                    controller: _departmentController,
                    hintText: 'Department',
                    icon: Icons.work,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Education",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTextFieldWithIcon(
                    controller: _educationController,
                    hintText: 'Education',
                    icon: Icons.work,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Employment status",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTextFieldWithIcon(
                    controller: _employmentStatusController,
                    hintText: 'Employment status',
                    icon: Icons.work,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Work schedule",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTextFieldWithIcon(
                    controller: _workScheduleController,
                    hintText: 'Work schedule',
                    icon: Icons.work,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Company employment id",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildTextFieldWithIcon(
                              controller: _companyEmployeeIDController,
                              hintText: 'Company employment id',
                              icon: Icons.work,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Manager id",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildTextFieldWithIcon(
                              controller: _managerIDController,
                              hintText: 'Manager id',
                              icon: Icons.work,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //========================

                  const SizedBox(height: 20),
                  const Text(
                    "Joining date",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    color: Color.fromARGB(255, 240, 239, 239),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _joiningDateController,
                            decoration: InputDecoration(
                              border:
                                  InputBorder.none, // Remove the border line
                              focusedBorder:
                                  InputBorder.none, // Remove the focused border
                              enabledBorder:
                                  InputBorder.none, // Remove the enabled border
                              errorBorder:
                                  InputBorder.none, // Remove the error border
                              disabledBorder: InputBorder.none,
                              hintText: 'Joining date',
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.date_range),
                                onPressed: _selectDate,
                              ),
                              // border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width / 3,
                        height: 50,
                        child: ElevatedButton(
                          onPressed:
                              _isUpdating ? null : _updateEmployeeProfile,
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 61, 124, 251),
                          ),
                          child: _isUpdating
                              ? CircularProgressIndicator() // Show loading indicator
                              : Text(
                                  'Save',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
