import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled/employeemanagement/addleave_request.dart';
import 'package:untitled/navigation_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var idController = TextEditingController();

  void submitData() async {
    final body = json.encode({
      "EmailId": emailController.text,
      "Password": passController.text,
      "CompanyCode": idController.text,
    });

    final url = 'https://employeemanagement.thedigitalindia.com/api/LoginApi/ChkLogin';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 302) {
        final responseData = json.decode(response.body);

        print('Full response data: $responseData');

        int employeeId = 0;  // Default to 0 in case of null or invalid values

        // Extract employeeId based on the response structure
        if (responseData is List && responseData.isNotEmpty && responseData[0] is Map) {
          final data = responseData[0];
          employeeId = int.tryParse(data['EmployeeId'].toString()) ?? 0;
        } else if (responseData is Map && responseData['data'] != null) {
          employeeId = int.tryParse(responseData['data']['EmployeeId'].toString()) ?? 0;
        }

        if (employeeId > 0) {
          print('Parsed EmployeeId: $employeeId');

          // Navigate to NavigationHomeScreen with valid employeeId
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationHomeScreen(employyeID: employeeId),
            ),
          );
        } else {
          print('Error: Employee ID is null or invalid.');
          _showErrorDialog('Failed to retrieve Employee ID.');
        }
      } else {
        print('Error: ${response.statusCode}');
        _showErrorDialog('Login failed. Please check your credentials.');
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog('An error occurred. Please try again.');
    }
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(21.0),
                child: Icon(Icons.account_circle, size: 100, color: Colors.blue),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    label: Text('Company ID'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 11),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 11),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    label: Text('Password'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 11),
              ElevatedButton(
                onPressed: submitData,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeavesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaves'),
      ),
      body: Center(
        child: Text('Leaves Page'),
      ),
    );
  }
}
