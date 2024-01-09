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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Attendance Data'),
        ),
        body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final attendanceList = snapshot.data;

              if (attendanceList == null || attendanceList.isEmpty) {
                return Text('No data available.');
              }

              return ListView.builder(
                itemCount: attendanceList.length,
                itemBuilder: (context, index) {
                  final attendanceData = attendanceList[index];

                  if (attendanceData == null ||
                      attendanceData['monthYear'] == null ||
                      attendanceData['counts'] == null) {
                    return SizedBox.shrink(); // Skip rendering this item
                  }

                  return ListTile(
                    title: Text('Month Year: ${attendanceData['monthYear']}'),
                    subtitle: Text('Counts: ${attendanceData['counts']}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://employee-management-u6y6.onrender.com/app/attendence/getAttendenceByUserId/6591789d740a144c89d9dced'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(await response.stream.bytesToString());
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load data');
    }
  }
}





