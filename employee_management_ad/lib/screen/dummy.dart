// import 'dart:convert';
// import 'package:employee_management_ad/model/userdata.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class TaskScreen extends StatefulWidget {
//   final UserData employee;

//   const TaskScreen({Key? key, required this.employee}) : super(key: key);

//   @override
//   _TaskScreenState createState() => _TaskScreenState();
// }

// class _TaskScreenState extends State<TaskScreen> {
//   Future<List<Map<String, dynamic>>> fetchTasks() async {
//     var request = http.Request(
//         'GET',
//         Uri.parse(
//             'http://localhost:2000/app/task/getIncompletedTaskByUserId/${widget.employee.sId}'));

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data =
//           json.decode(await response.stream.bytesToString());
//       return List<Map<String, dynamic>>.from(data['data']);
//     } else {
//       throw Exception('Failed to load tasks');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task List'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchTasks(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             List<Map<String, dynamic>> tasks = snapshot.data!;
//             return ListView.builder(
//               itemCount: tasks.length,
//               itemBuilder: (context, index) {
//                 final task = tasks[index];
//                 return ListTile(
//                   title: Text('Task ${index + 1}'),
//                   subtitle: Text(task['description'] ?? ''),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//======================
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AttendanceScreen extends StatefulWidget {
//   final String userId;

//   const AttendanceScreen({Key? key, required this.userId}) : super(key: key);

//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   List<Map<String, dynamic>> attendanceData = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final response = await http.get(Uri.parse(
//         'http://localhost:2000/app/attendence/getAttendenceByUserId/${widget.userId}'));

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);

//       setState(() {
//         attendanceData = List<Map<String, dynamic>>.from(
//             responseData['data'] as List<dynamic>);
//       });
//     } else {
//       // Handle errors here
//       print('Failed to load attendance data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance Screen'),
//       ),
//       body: ListView.builder(
//         itemCount: attendanceData.length,
//         itemBuilder: (context, index) {
//           final monthYear = attendanceData[index]['monthYear'];
//           final data = attendanceData[index]['data'] as List<dynamic>;

//           return ListTile(
//             title: Text('Month/Year: $monthYear'),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Present: ${data.length}'),
//                 Text('Leave: ${attendanceData[index]['counts']['Leave']}'),
//                 Text('Sunday: ${attendanceData[index]['counts']['Sunday']}'),
//               ],
//             ),
//             onTap: () {
//               // Handle tap, you can navigate to a detailed view or perform other actions
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: AttendanceScreen(
//         userId: '658ac7a2ef3819cc4ac60a7d'), // Replace with the actual user ID
//   ));
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holiday App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Map<String, dynamic>>> fetchData() async {
    var url = Uri.parse('http://192.168.29.135:2000/app/holiday/getHoliday');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holiday App'),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> holidays =
                snapshot.data as List<Map<String, dynamic>>;

            return ListView.builder(
              itemCount: holidays.length,
              itemBuilder: (context, index) {
                var holiday = holidays[index];
                var holidayName = holiday['holiday'];
                var holidayDate = holiday['holiDate'];

                return ListTile(
                  title: Text(holidayName),
                  subtitle: Text('Date: $holidayDate'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
