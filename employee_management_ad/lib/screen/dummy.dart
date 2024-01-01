// // main.dart

// import 'package:employee_management_ad/model/userdata.dart';
// import 'package:employee_management_ad/service/Employee_service.dart';
// import 'package:flutter/material.dart';
// // import 'models/employee.dart';
// // import 'services/employee_service.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Employee App',
//       home: EmployeeList(),
//     );
//   }
// }

// class EmployeeList extends StatefulWidget {
//   @override
//   _EmployeeListState createState() => _EmployeeListState();
// }

// class _EmployeeListState extends State<EmployeeList> {
//   final EmployeeService employeeService = EmployeeService();
//   late Future<List<UserData>> employees;

//   @override
//   void initState() {
//     super.initState();
//     // employees = EmployeeService.getEmployees();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Employee List'),
//       ),
//       body: FutureBuilder<List<UserData>>(
//         future: employees,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 UserData employee = snapshot.data![index];
//                 return ListTile(
//                   title: Text('${employee.firstName} ${employee.lastName}'),
//                   // subtitle: Text(employee.email),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
