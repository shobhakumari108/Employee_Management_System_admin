import 'dart:convert';

import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/screen/attendance_history_screen.dart';
import 'package:employee_management_ad/screen/edit_profile_screen.dart';
import 'package:employee_management_ad/screen/employee_list.dart';
import 'package:employee_management_ad/screen/home.dart';
import 'package:employee_management_ad/screen/task_screen.dart';
import 'package:employee_management_ad/widgets/task_complete.dart';
import 'package:employee_management_ad/widgets/task_incomplate.dart';
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
  Future<List<Map<String, dynamic>>>? attendanceData;
  // final TextEditingController salaryController = TextEditingController();
  // List<Map<String, dynamic>> data = [];
  void initState() {
    super.initState();
    attendanceData = attendanceDataGet();
    // salaryData();
    EmployeeSalary();
  }

  bool _isLoading = false;

  //salary=======================================

  double getSallary = 0;
  String actualSallary = 'Loading...';

  @override
  // void initState() {
  //   super.initState();
  //   fetchSalary();
  // }
  Future<void> EmployeeSalary() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://employee-management-u6y6.onrender.com/app/attendence/sallaryByUserId/${widget.employee.sId}'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        final double getSallaryValue = data['data'][0]['counts']['GetSallary'];
        final String actualSallaryValue = data['ActualSallary'];

        setState(() {
          getSallary = getSallaryValue;
          actualSallary = 'Actual Salary: $actualSallaryValue';
        });
      } else {
        setState(() {
          actualSallary = 'Failed to fetch salary: ${response.reasonPhrase}';
        });
      }
    } catch (error) {
      setState(() {
        actualSallary = 'Error: $error';
      });
    }
  }

  //===========================
  //atendance===============================
  Future<List<Map<String, dynamic>>> attendanceDataGet() async {
    var request = http.Request(
      'GET',
      Uri.parse(
          'https://employee-management-u6y6.onrender.com/app/attendence/getAttendenceByUserId/${widget.employee.sId}'),
    );

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic jsonData =
          json.decode(await response.stream.bytesToString());

      if (jsonData is List) {
        // Handle the case where the response is a list (if applicable)
        return jsonData.cast<Map<String, dynamic>>();
      } else if (jsonData is Map) {
        // Handle the case where the response is a map
        if (jsonData.containsKey('data') && jsonData['data'] is List) {
          return jsonData['data'].cast<Map<String, dynamic>>();
        } else {
          throw Exception('Invalid JSON format');
        }
      } else {
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  //==========================================

  //================================================
  // Future<List<Map<String, dynamic>>> incompleteTasks() async {
  //   print(";=========");
  //   // Dynamically construct the URL using widget.employee.sId
  //   String getTaskUrl =
  //       'http://localhost:2000/app/task/getIncompletedTaskByUserId/${widget.employee.sId}';

  //   try {
  //     final response = await http.get(Uri.parse(getTaskUrl));

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       return List<Map<String, dynamic>>.from(data['data']);
  //     } else {
  //       throw Exception('Failed to load tasks');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching tasks: $e');
  //   }
  // }

  // Future<List<Map<String, dynamic>>> completeTasks() async {
  //   print(";=========");
  //   // Dynamically construct the URL using widget.employee.sId
  //   String getTaskUrl =
  //       'http://localhost:2000/app/task/getCompletedTaskByUserId/${widget.employee.sId}';

  //   try {
  //     final response = await http.get(Uri.parse(getTaskUrl));

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       return List<Map<String, dynamic>>.from(data['data']);
  //     } else {
  //       throw Exception('Failed to load tasks');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching tasks: $e');
  //   }
  // }

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
            builder: (context) => HomeScreen(),
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
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.blueGrey[100],
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: BackButtonIcon(), // or Icon(Icons.arrow_back),
                onPressed: () {
                  // Handle back button press or navigate back
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
              title: Card(
                color: Colors.blueGrey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Employee Profile",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.person))
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * .4 - 58,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: size.width * .4 - 58,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[100],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: (widget.employee
                                                          .profilePhoto ??
                                                      '')
                                                  .isNotEmpty
                                              ? Image.network(
                                                  widget.employee.profilePhoto!,
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                )
                                              : const Icon(
                                                  Icons.person,
                                                  size: 50,
                                                  color: Color.fromARGB(
                                                      255, 61, 124, 251),
                                                ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        '${widget.employee.firstName} ${widget.employee.lastName}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 61, 124, 251)),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Text(
                                        "Contact information",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text('Email : ${widget.employee.email}'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Phone number : ${widget.employee.mobileNumber}'),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "General information",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // Text(
                                      //   'Name : ${widget.employee.firstName} ${widget.employee.lastName}',
                                      // ),
                                      Text(
                                          'Job title : ${widget.employee.jobTitle}'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Education : ${widget.employee.education}'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Joining date : ${widget.employee.joiningDate}'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Company name : ${widget.employee.companyName}',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Employee id : ${widget.employee.companyEmployeeID}"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Department : ${widget.employee.department}"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Employment status : ${widget.employee.employmentStatus}"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Maneger id : ${widget.employee.managerID}"),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "Additional information",
                                        style: TextStyle(fontSize: 20),
                                      ),

                                      Text(
                                          "Address : ${widget.employee.address}"),

                                      const SizedBox(
                                        height: 40,
                                      ),

                                      Text(
                                          'Payment : ${getSallary.toStringAsFixed(2)}'),
                                      const SizedBox(height: 20),
                                      // Text(actualSallary),
                                      Text(
                                          "Salary : ${widget.employee.salary}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: size.width * .6 - 58,
                        child: Column(
                          children: [
                            FutureBuilder(
                              future: attendanceData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(255, 61, 124, 251),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final attendanceList = snapshot.data
                                      as List<Map<String, dynamic>>?;

                                  if (attendanceList == null ||
                                      attendanceList.isEmpty) {
                                    return Text(
                                        'No attendance data available.');
                                  }

                                  return Column(
                                    children: [
                                      const Text(
                                        'Attendance Data',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: attendanceList.length,
                                        itemBuilder: (context, index) {
                                          final attendanceData =
                                              attendanceList[index];

                                          if (attendanceData == null ||
                                              attendanceData['monthYear'] ==
                                                  null ||
                                              attendanceData['counts'] ==
                                                  null) {
                                            return SizedBox
                                                .shrink(); // Skip rendering this item
                                          }

                                          return Column(children: [
                                            Text(
                                              'Date : ${attendanceData['monthYear']}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 80,
                                                  width: size.width / 10,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                            '${attendanceData['counts']['Present']}'),
                                                        Text('Present'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 80,
                                                  width: size.width / 10,
                                                  decoration: BoxDecoration(
                                                      color: Colors.cyan,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                            '${attendanceData['counts']['Leave']}'),
                                                        Text('Leave'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 80,
                                                  width: size.width / 10,
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                            '${attendanceData['counts']['Holiday']}'),
                                                        Text('Holiday'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 80,
                                                  width: size.width / 10,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                            '${attendanceData['counts']['Sunday']}'),
                                                        Text('Sunday'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ]);
                                        },
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                disabledElevation: 0,
                elevation: 0,
                hoverElevation: 0,
                autofocus: false,
                hoverColor: Colors.white,
                onPressed: () {
                  // Add your FAB click logic here
                },
                child: PopupMenuButton<String>(
                  padding: EdgeInsets.zero, // Set padding to zero
                  // offset: const Offset(0, 40), // Adjust the offset as needed

                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EmployeeEditScreen(employee: widget.employee),
                        ),
                      );
                    } else if (value == 'delete') {
                      _showDeleteConfirmation(context);
                    } else if (value == 'task') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TaskScreen(employee: widget.employee),
                        ),
                      );
                    } else if (value == 'attendance') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AttendanceScreen(employee: widget.employee),
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: ListTile(
                          // leading: Icon(Icons.edit),
                          title: Text('Edit'),
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: ListTile(
                          // leading: Icon(Icons.delete),
                          title: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'task',
                        child: ListTile(
                          // leading: Icon(Icons.delete),
                          title: Text('Task'),
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'attendance',
                        child: ListTile(
                          // leading: Icon(Icons.delete),
                          title: Text('Attendance history'),
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          ),
        ),
      ),
    );
  }
}
