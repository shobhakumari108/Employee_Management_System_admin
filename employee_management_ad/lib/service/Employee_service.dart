import 'dart:convert';
import 'dart:io';
import 'package:employee_management_ad/model/userdata.dart';
import 'package:employee_management_ad/util/toaster.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:employee_management_ad/model/userdata.dart';

class EmployeeService {
  static const String apiUrl = "http://192.168.29.135:2000/app/users/addUser";

  static Future<bool> addEmployee(UserData user) async {
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization':
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyRGF0YSI6eyJ1c2VybmFtZSI6IlNvYmhhIiwiZW1haWwiOiJTazEyM0BnbWFpbC5jb20iLCJpZCI6IjY1OGFjN2EyZWYzODE5Y2M0YWM2MGE3ZCIsImZpcnN0TmFtZSI6IlNvYmhhIiwibGFzdE5hbWUiOiJLdW1hcmkifSwiaWF0IjoxNzAzOTEzMDg3LCJleHAiOjE3MDQzNDUwODd9.MgFDmIudXWDHy065SB6BWRkFg94I8uszutfk9hf9RWY'
    };

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: json.encode({
        "FirstName": user.firstName,
        "LastName": user.lastName,
        "Email": user.email,
        "Password": user.password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("================Sign-up successful====================");
      print(await response.body);
      showToast("Employee added successfully", Colors.black);
      return true; // Employee added successfully
    } else {
      print("================Sign-up failed====================");
      print(response.reasonPhrase);
      showToast("Failed to add employee", Colors.red);

      return false; // Failed to add employee
    }
  }
  //------------------------------------------

  //--------------------------------------------

//   //======================================

  static const String getEmployeeUrl =
      "http://192.168.29.135:2000/app/users/getUsers";
  static Future<List<UserData>> getEmployees() async {
    try {
      final response = await http.get(Uri.parse(getEmployeeUrl));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData != null && responseData is Map<String, dynamic>) {
          final List<dynamic>? data = responseData['data'];

          if (data != null) {
            return data
                .map((e) => UserData.fromJson(e))
                .whereType<UserData>()
                .toList();
          } else {
            throw Exception(
                'Invalid response format: Missing or null "data" key');
          }
        } else {
          throw Exception(
              'Invalid response format: Expected a Map, but got ${responseData.runtimeType}');
        }
      } else {
        throw Exception('Failed to load employees: ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error in getEmployees: $e");
      throw e;
    }
  }

  static Future<bool> updateEmployee(UserData employee) async {
    try {
      String updateEmployeeUrl =
          "http://192.168.29.135:2000/app/users/updateUser/${employee.sId}";

      var request = http.MultipartRequest('PUT', Uri.parse(updateEmployeeUrl))
        ..fields['FirstName'] = employee.firstName ?? ''
        ..fields['LastName'] = employee.lastName ?? ''
        ..fields['Email'] = employee.email ?? ''
        ..fields['MoblieNumber'] = employee.mobileNumber ?? ''
        ..fields['JobTitle'] = employee.jobTitle ?? ''
        ..fields['ComapnyEmplyeeID'] = employee.companyEmployeeID ?? ''
        ..fields['ManagerId'] = employee.managerID ?? ''
        // ..fields['JobTitlee'] = employee.jobTitle ?? ''
        ..fields['CompanyName'] = employee.companyName ?? ''
        ..fields['Address'] = employee.address ?? ''
        ..fields['Department'] = employee.department ?? ''
        ..fields['Education'] = employee.education ?? ''
        ..fields['EmploymentStatus'] = employee.employmentStatus ?? ''
        ..fields['WorkSedule'] = employee.workSchedule ?? '';
      // ..fields['joiningDate'] = employee.joiningDate ?? '';
      print("++++++++++++++++++++++++++++++++++++++++");
      print(
          "1${employee.firstName},2${employee.lastName},3${employee.email},4${employee.mobileNumber},5${employee.jobTitle},8${employee.companyName},9${employee.address},10${employee.department},11${employee.education},12${employee.employmentStatus},13${employee.workSchedule}");
      if (employee.profilePhoto != null && employee.profilePhoto!.isNotEmpty) {
        var file = File(employee.profilePhoto!);
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();

        var multipartFile = http.MultipartFile('ProfilePicture', stream, length,
            filename: file.path.split("/").last);

        request.files.add(multipartFile);
      }

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        print("Profile updated");
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      print("Error in updateEmployee: $e");
      throw e;
    }
  }
}
