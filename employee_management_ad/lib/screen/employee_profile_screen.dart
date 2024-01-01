import 'package:employee_management_ad/model/userdata.dart';
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
        'http://192.168.29.77:2000/app/users/deleteUser/${employee.sId}';

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

  Widget _buildProfileCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // color: Colors.blue,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: ListView(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage(employee.profilePhoto ?? ''),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileCard(
                    'Name',
                    '${employee.firstName} ${employee.lastName}',
                  ),
                  _buildProfileCard('Email', '${employee.email}'),
                  _buildProfileCard('Phone Number', '${employee.mobileNumber}'),
                  _buildProfileCard('Job Type', '${employee.companyName}'),
                  _buildProfileCard('Joining Date', '${employee.education}'),
                  _buildProfileCard(
                    'Company Name',
                    '${employee.companyName}',
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // Other container properties...

                    // Popup menu button
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        // Handle the selected option
                        if (value == 'edit') {
                          // Perform edit action
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
    );
  }
}
