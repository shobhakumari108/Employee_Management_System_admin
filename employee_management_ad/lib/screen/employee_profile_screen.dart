import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/screen/edit_profile_screen.dart';
import 'package:employee_management_ad/screen/employee_list.dart';
import 'package:employee_management_ad/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EmployeeProfileScreen extends StatelessWidget {
  final UserData employee;

  const EmployeeProfileScreen({Key? key, required this.employee})
      : super(key: key);

  Future<void> _deleteProfile(BuildContext context) async {
    final url =
        'http://192.168.29.135:2000/app/users/deleteUser/${employee.sId}';

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
    return Scaffold(
      appBar: buildAppBar(context, "Profile Screen"),
      // appBar: AppBar(
      //   title: Text('Employee Profile'),
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back,
      //     ),
      //     onPressed: () {
      //       //   Navigator.pushAndRemoveUntil(
      //       //     context,
      //       //     MaterialPageRoute(
      //       //       builder: (context) => EmployeeScreen(),
      //       //     ),
      //       //     (route) => false,
      //       //   );
      //     },
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const CircleAvatar(
      //         // backgroundColor: const Color.fromARGB(100, 240, 202, 89),
      //         child: Icon(
      //           Icons.edit,
      //           color: Color.fromARGB(255, 121, 91, 3),
      //         ),
      //       ),
      //       onPressed: () {
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(
      //         //     builder: (context) => EmployeeEditScreen(employee: employee),
      //         //   ),
      //         // );
      //       },
      //     ),
      //     IconButton(
      //       icon: const CircleAvatar(
      //         // backgroundColor:const Color.fromARGB(100, 240, 202, 89) ,
      //         child: Icon(
      //           Icons.delete,
      //           color: Color.fromARGB(255, 121, 91, 3),
      //         ),
      //       ),
      //       onPressed: () {
      //         _showDeleteConfirmation(context);
      //       },
      //     ),
      //   ],
      // ),
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
                        borderRadius: BorderRadius.circular(
                            10), // Optional: Add border radius for rounded corners
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Optional: Add border radius for rounded corners
                        child: Image.network(
                          employee.profilePhoto ?? '',
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
                        Text('Email : ${employee.email}'),
                        Text('Phone number : ${employee.mobileNumber}'),
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
                          'Name : ${employee.firstName} ${employee.lastName}',
                        ),
                        Text('Job title : ${employee.jobTitle}'),
                        Text('Joining date : ${employee.education}'),
                        Text(
                          'Company name : ${employee.companyName}',
                        ),
                        Text("Employee id : ${employee.companyEmployeeID}"),
                        Text("Department : ${employee.department}"),
                        Text(
                            "Employment status : ${employee.employmentStatus}"),
                        Text("Maneger id : ${employee.managerID}"),
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
                        Text("Address : ${employee.address}"),
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
                      // Other container properties...

                      // Popup menu button
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          // Handle the selected option
                          if (value == 'edit') {
                            // Perform edit action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeEditScreen(employee: employee),
                              ),
                            );
                          } else if (value == 'delete') {
                            // Perform delete action
                            _showDeleteConfirmation(context);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              value: 'edit',
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
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
    );
  }
}
