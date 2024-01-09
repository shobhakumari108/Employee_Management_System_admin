import 'dart:convert';
import 'package:employee_management_ad/util/toaster.dart';
import 'package:employee_management_ad/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Post Holiday Data'),
//         ),
//         body: PostHolidayForm(),
//       ),
//     );
//   }
// }

class HolidayScreen extends StatefulWidget {
  @override
  _HolidayScreenState createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  final TextEditingController holidayController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String responseMessage = '';
  late FocusNode holidayFocusNode;

  @override
  void initState() {
    super.initState();
    holidayFocusNode = FocusNode();
  }

  @override
  void dispose() {
    holidayFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> postHolidayData() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://employee-management-u6y6.onrender.com/app/holiday/addHoliday'));

    // Format the date without the time component
    String formattedDate =
        selectedDate.toLocal().toIso8601String().substring(0, 10);

    request.body = json.encode({
      "holiday": holidayController.text,
      "holiDate": formattedDate,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print(response.body);
      print("================");
      // setState(() {
      //   responseMessage = 'Holiday data posted successfully';
      // });

      showToast("'Holiday data posted successfully'", Colors.green);
    } else {
      // setState(() {
      //   responseMessage =
      //       'Failed to post holiday data: ${response.reasonPhrase}';
      // });

      showToast(
          "Failed to post holiday data: ${response.reasonPhrase}", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Holiday",
            style: TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 61, 124, 251),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            width: size.width * .5,
            color: Color.fromARGB(255, 240, 239, 239),
            child: buildTextFieldWithIcon(
              controller: holidayController,
              hintText: 'Holiday',
              icon: Icons.lock,
              // focusNode: holidayFocusNode,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            height: 50,
            width: size.width * .5,
            color: Color.fromARGB(255, 240, 239, 239),
            child: TextFormField(
              readOnly: true,
              controller: TextEditingController(
                text:
                    '${selectedDate.toLocal().toString().split(' ')[0]}', // Display only the date
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
                // labelText: 'Holiday Date',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: size.width / 3,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                postHolidayData();
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 61, 124, 251),
              ),
              child: Text(
                'Send',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Text(responseMessage),
        ],
      ),
    );
  }
}