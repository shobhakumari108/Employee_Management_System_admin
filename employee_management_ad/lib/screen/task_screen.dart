import 'dart:convert';
import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/widgets/task_complete.dart';
import 'package:employee_management_ad/widgets/task_incomplate.dart';
import 'package:employee_management_ad/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskScreen extends StatefulWidget {
  final UserData employee;

  const TaskScreen({Key? key, required this.employee}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController taskController = TextEditingController();
  List<String> tasks = []; // List to store tasks

//==================
  Future<List<Map<String, dynamic>>> incompleteTasks() async {
    print(";=========");
    // Dynamically construct the URL using widget.employee.sId
    String getTaskUrl =
        'https://employee-management-u6y6.onrender.com/app/task/getIncompletedTaskByUserId/${widget.employee.sId}';

    try {
      final response = await http.get(Uri.parse(getTaskUrl));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  Future<List<Map<String, dynamic>>> completeTasks() async {
    print(";=========");
    // Dynamically construct the URL using widget.employee.sId
    String getTaskUrl =
        'https://employee-management-u6y6.onrender.com/app/task/getCompletedTaskByUserId/${widget.employee.sId}';

    try {
      final response = await http.get(Uri.parse(getTaskUrl));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }
//==================

  Future<void> postTask(UserData user, String task) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://employee-management-u6y6.onrender.com/app/task/addTask'));

    request.body = json.encode({
      "UserID": user.sId,
      "task": task,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(await response.stream.bytesToString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task posted successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear the text field after successful posting
        taskController.clear();

        // Update the list of tasks and rebuild the UI
        setState(() {
          tasks.add(task);
        });
      } else {
        print(response.reasonPhrase);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to post task'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error posting task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error posting task'),
          backgroundColor: Colors.red,
        ),
      );
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
                            "Task Profile",
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 16.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * .3 - 36,
                          child: Column(
                            children: [
                              buildTextFieldWithIcon(
                                controller: taskController,
                                hintText: 'Task',
                                icon: Icons.note_add,
                                // decoration: InputDecoration(labelText: 'Task'),
                              ),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    postTask(
                                        widget.employee, taskController.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 61, 124, 251),
                                  ),
                                  child: const Text(
                                    'Add task',
                                    style: TextStyle(
                                      // fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 16.0),
                              const SizedBox(height: 20.0),
                              // Display previously posted tasks
                              const Text(
                                'Previously Posted Tasks:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              if (tasks.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (String task in tasks) Text('- $task'),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          width: size.width * .3 - 36,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Pending Tasks:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              IncompeletTaskWidget(
                                taskList: incompleteTasks(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: size.width * .3 - 36,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: const Text(
                                    'Completed Tasks:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TaskListCompletedWidget(
                                taskList: completeTasks(),
                              ),
                            ],
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
      ),
    );
  }
}
