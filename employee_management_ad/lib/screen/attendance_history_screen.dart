import 'dart:convert';
import 'package:employee_management_ad/model/userdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AttendanceScreen extends StatefulWidget {
  final UserData employee;

  const AttendanceScreen({super.key, required this.employee});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<dynamic> attendanceData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var apiUrl =
        'https://employee-management-u6y6.onrender.com/app/attendence/getAttendenceByUserId/${widget.employee.sId}';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          setState(() {
            attendanceData = jsonResponse['data'];
          });
        } else {
          print('API Error: ${jsonResponse['message']}');
        }
      } else {
        print('Failed to fetch data. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.blueGrey[100],
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              // leading: const Icon(
              //   Icons.arrow_back_rounded,
              // ),
              title: Card(
                color: Colors.blueGrey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Attendance History",
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var monthData in attendanceData)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${monthData['monthYear']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        for (var attendance
                            in (monthData['data'] as List<dynamic>))
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Container(
                                width: size.width * .6 + 42,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                if (attendance['Photo']
                                                    .isNotEmpty)
                                                  if (attendance['Photo']
                                                      .isNotEmpty)
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        attendance['Photo'],
                                                      ),
                                                    ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        'Date: ${attendance['attendenceDate']}'),
                                                    Text(
                                                      'Time: ${attendance['ClockInDateTime']}',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '${attendance['Status']}',
                                              style: TextStyle(
                                                  color: statusColor(
                                                      attendance['Status']),
                                                  fontWeight: FontWeight.bold),
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

  Color statusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      case 'Leave':
        return Colors.cyan;
      case 'Holiday':
        return Colors.yellow;
      default:
        return Colors.black;
    }
  }
}
