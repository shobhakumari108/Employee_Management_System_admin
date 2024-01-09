import 'package:flutter/material.dart';

class IncompeletTaskWidget extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> taskList;

  IncompeletTaskWidget({required this.taskList});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: taskList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 61, 124, 251),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No tasks available.');
        } else {
          List<Map<String, dynamic>> tasks = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Pending',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              for (var task in tasks)
                ListTile(
                  title: Text(task['task'] ?? ' '),
                  subtitle: Text('Created at: ${task['createdAt']}'),
                ),
            ],
          );
        }
      },
    );
  }
}
