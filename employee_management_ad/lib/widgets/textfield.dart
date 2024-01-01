import 'package:flutter/material.dart';

Widget buildTextFieldWithIcon({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  TextInputType? keyboardType,
}) {
  return Container(
    height: 50,
    color: Color.fromARGB(255, 240, 239, 239),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      // style: TextStyle(color: Colors.grey), // Set text color to gray
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        // hintStyle: TextStyle(color: Colors.grey), // Set hint color to gray
        // prefixIcon: Icon(icon, color: Colors.grey), // Set icon color to gray
        border: InputBorder.none, // Remove the border line
        focusedBorder: InputBorder.none, // Remove the focused border
        enabledBorder: InputBorder.none, // Remove the enabled border
        errorBorder: InputBorder.none, // Remove the error border
        disabledBorder: InputBorder.none, // Remove the disabled border
        contentPadding: EdgeInsets.all(16), // Add padding to the content
      ),
    ),
  );
}
