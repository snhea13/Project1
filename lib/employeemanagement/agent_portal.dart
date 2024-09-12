import 'package:flutter/material.dart';
import 'package:untitled/employeemanagement/addleave_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(EmployeeManagementApp());

class EmployeeManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EmployeeManagementPage(employeeId: 123), // Pass the employeeId here
    );
  }
}

class LeaveRequest {
  final String agentName;
  final String leaveType;
  final String document;
  final String status;

  LeaveRequest({
    required this.agentName,
    required this.leaveType,
    required this.document,
    required this.status,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      agentName: json['Agent_Name'],
      leaveType: json['LeaveType'],
      document: json['Document'] ?? '',
      status: json['Status'],
    );
  }
}

Future<List<LeaveRequest>> fetchLeaveRequests() async {
  const url = 'https://employeemanagement.thedigitalindia.com/api/AgentLeaveApi/GetLeaveRequests';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => LeaveRequest.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load leave requests');
  }
}

class EmployeeManagementPage extends StatefulWidget {
  final int employeeId; // Employee ID passed in the constructor

  EmployeeManagementPage({required this.employeeId}); // Require employeeId

  @override
  _EmployeeManagementPageState createState() => _EmployeeManagementPageState();
}

class _EmployeeManagementPageState extends State<EmployeeManagementPage> {
  late Future<List<LeaveRequest>> futureLeaveRequests;

  @override
  void initState() {
    super.initState();
    futureLeaveRequests = fetchLeaveRequests();
  }

  void _showModal(BuildContext context, String title, String placeholder, Function(String) onSubmit) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: placeholder,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                onSubmit(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDocumentDialog(BuildContext context, String document) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Document'),
          content: Text('Content of $document'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Leaves'),
        backgroundColor: Color(0xFF3A57C4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous page
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddLeaveRequestPage(employeeId: widget.employeeId), // Pass employeeId to AddLeaveRequestPage
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<LeaveRequest>>(
        future: futureLeaveRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No leave requests found.'));
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Agent Name', style: TextStyle(color: Colors.blue))),
                  DataColumn(label: Text('Leave Type', style: TextStyle(color: Colors.blue))),
                  DataColumn(label: Text('Document', style: TextStyle(color: Colors.blue))),
                  DataColumn(label: Text('Status', style: TextStyle(color: Colors.blue))),
                ],
                rows: snapshot.data!.map((leaveRequest) {
                  return DataRow(
                    cells: [
                      DataCell(Text(leaveRequest.agentName)),
                      DataCell(Text(leaveRequest.leaveType)),
                      DataCell(
                        ElevatedButton(
                          onPressed: () => _showDocumentDialog(context, leaveRequest.document),
                          child: const Text('View'),
                        ),
                      ),
                      DataCell(Text(leaveRequest.status)),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
