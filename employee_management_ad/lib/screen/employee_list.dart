// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/screen/employee_profile_screen.dart';
import 'package:employee_management_ad/screen/home.dart';
import 'package:employee_management_ad/service/Employee_service.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  TextEditingController _searchController = TextEditingController();
  List<UserData> _employees = [];
  List<UserData> _filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
    print("---");
  }

  Future<void> _loadEmployees() async {
    try {
      final employees = await EmployeeService.getEmployees();
      print("Fetched employees: $employees");
      setState(() {
        _employees = employees;
        _filteredEmployees = employees;
      });
    } catch (e) {
      print("Error loading employees: $e");
    }
  }

  void _searchEmployees(String query) {
    final lowerCaseQuery = query.toLowerCase();
    setState(() {
      _filteredEmployees = _employees
          .where((employee) =>
              (employee.firstName?.toLowerCase() ?? '')
                  .contains(lowerCaseQuery) ||
              (employee.lastName?.toLowerCase() ?? '')
                  .contains(lowerCaseQuery) ||
              _isFullNameMatch(employee, lowerCaseQuery) ||
              (employee.email?.toLowerCase() ?? '').contains(lowerCaseQuery))
          .toList();

      // Sort the filtered employees based on the search query
      _filteredEmployees.sort((a, b) {
        // Check if the name exactly matches the search query
        if (_isFullNameMatch(a, lowerCaseQuery) ||
            (a.email?.toLowerCase() ?? '') == lowerCaseQuery) {
          return -1; // Place a at the top
        } else if (_isFullNameMatch(b, lowerCaseQuery) ||
            (b.email?.toLowerCase() ?? '') == lowerCaseQuery) {
          return 1; // Place b at the top
        } else {
          // Use a default sorting logic if no exact match
          return (a.firstName?.toLowerCase() ?? '')
              .compareTo(b.firstName?.toLowerCase() ?? '');
        }
      });
    });
  }

  bool _isFullNameMatch(UserData employee, String query) {
    // Check if the combination of first and last names matches the search query
    final fullName = '${employee.firstName} ${employee.lastName}';
    return fullName.toLowerCase().contains(query);
  }

  @override
  Widget build(BuildContext context) {
    print("==========");
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "Profile Screen"),
      // appBar: AppBar(
      //   title: Text('Employee List'),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       // Navigator.pushAndRemoveUntil(
      //       //   context,
      //       //   MaterialPageRoute(
      //       //     builder: (context) => MyHomePage(),
      //       //   ),
      //       //   (route) => false,
      //       // ); // This will pop the current screen off the stack and navigate back.
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width,
                  child: TextField(
                    controller: _searchController,
                    onChanged: _searchEmployees,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Enter search query',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: _filteredEmployees.map((employee) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EmployeeProfileScreen(employee: employee),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(employee.profilePhoto ?? ''),
                          ),
                          title: Text(
                              '${employee.firstName ?? ""} ${employee.lastName ?? ""}'),
                          subtitle: Text('Email: ${employee.email ?? ""}'),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromARGB(255, 121, 91, 3),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => AddEmployeeScreen()),
      //     );
      //   },
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
