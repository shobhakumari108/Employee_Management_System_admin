import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/screen/edit_profile_screen.dart';
import 'package:employee_management_ad/screen/employee_list.dart';
import 'package:employee_management_ad/screen/home.dart';
import 'package:employee_management_ad/screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EmployeeProfileScreen extends StatefulWidget {
  final UserData employee;

  const EmployeeProfileScreen({super.key, required this.employee});

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  bool _isLoading = false;

  Future<void> _deleteProfile(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final url =
        'http://192.168.29.135:2000/app/users/deleteUser/${widget.employee.sId}';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: 'Profile deleted');
        print("deleted");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeScreen(),
          ),
          (route) => false,
        );
      } else {
        print('Failed to delete profile. Status code: ${response.statusCode}');
        Fluttertoast.showToast(msg: 'Failed to delete profile');
      }
    } catch (error) {
      print('Error deleting profile: $error');
      Fluttertoast.showToast(msg: 'Error deleting profile');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteProfile(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Card(
        child: Scaffold(
          // appBar: buildAppBar(context, "Profile Screen"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.employee.profilePhoto ?? '',
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact information",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Email : ${widget.employee.email}'),
                            Text(
                                'Phone number : ${widget.employee.mobileNumber}'),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "General information",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Name : ${widget.employee.firstName} ${widget.employee.lastName}',
                            ),
                            Text('Job title : ${widget.employee.jobTitle}'),
                            Text('Joining date : ${widget.employee.education}'),
                            Text(
                              'Company name : ${widget.employee.companyName}',
                            ),
                            Text(
                                "Employee id : ${widget.employee.companyEmployeeID}"),
                            Text("Department : ${widget.employee.department}"),
                            Text(
                                "Employment status : ${widget.employee.employmentStatus}"),
                            Text("Maneger id : ${widget.employee.managerID}"),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Additional information",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Address : ${widget.employee.address}"),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EmployeeEditScreen(
                                                  employee: widget.employee),
                                        ),
                                      );
                                    } else if (value == 'delete') {
                                      _showDeleteConfirmation(context);
                                    } else if (value == 'task') {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => TaskScreen(
                                      //         employee: widget.employee),
                                      //   ),
                                      // );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      PopupMenuItem<String>(
                                        value: 'edit',
                                        child: ListTile(
                                          // leading: Icon(Icons.edit),
                                          title: Text('Edit'),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'delete',
                                        child: ListTile(
                                          // leading: Icon(Icons.delete),
                                          title: Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'task',
                                        child: ListTile(
                                          // leading: Icon(Icons.delete),
                                          title: Text('task'),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                        ),
                      ],
                    ),
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
