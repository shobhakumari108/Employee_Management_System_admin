// import 'dart:convert';
// import 'package:employee_management_ad/model/userdata.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class TaskScreen extends StatefulWidget {
//   final UserData employee;

//   const TaskScreen({Key? key, required this.employee}) : super(key: key);

//   @override
//   State<TaskScreen> createState() => _TaskScreenState();
// }

// class _TaskScreenState extends State<TaskScreen> {
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController task1Controller = TextEditingController();
//   final TextEditingController task2Controller = TextEditingController();
//   final TextEditingController task3Controller = TextEditingController();

//   DateTime selectedDate = DateTime.now();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime picked = (await showDatePicker(
//           context: context,
//           initialDate: selectedDate,
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2101),
//         )) ??
//         selectedDate;

//     if (picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         dateController.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }

//   Future<void> addTask(UserData user) async {
//     var headers = {'Content-Type': 'application/json'};
//     var request = http.Request(
//         'POST', Uri.parse('http://192.168.29.135:2000/app/task/addTask'));
//     request.body = json.encode({
//       "UserID": user.sId,
//       "Date": dateController.text,
//       "tasks": [
//         {"task": task1Controller.text, "completed": false},
//         {"task": task2Controller.text, "completed": false},
//         {"task": task3Controller.text, "completed": false}
//       ]
//     });
//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () => _selectDate(context),
//               child: InputDecorator(
//                 decoration: InputDecoration(
//                   labelText: 'Date',
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text("${selectedDate.toLocal()}".split(' ')[0]),
//                     Icon(Icons.calendar_today),
//                   ],
//                 ),
//               ),
//             ),
//             TextField(
//               controller: task1Controller,
//               decoration: InputDecoration(labelText: 'Task 1'),
//             ),
//             TextField(
//               controller: task2Controller,
//               decoration: InputDecoration(labelText: 'Task 2'),
//             ),
//             TextField(
//               controller: task3Controller,
//               decoration: InputDecoration(labelText: 'Task 3'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 addTask(widget.employee);
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
