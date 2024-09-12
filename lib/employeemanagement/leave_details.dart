import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/employeemanagement/addleave_request.dart';

void main() => runApp(EmployeeManagementApp(leaveId: 51));

class EmployeeManagementApp extends StatelessWidget {
  final int leaveId;

  const EmployeeManagementApp({required this.leaveId});  // Accept leaveId in constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EmployeeManagementPage(leaveId: leaveId), // Pass leaveId as a named argument
    );
  }
}
class EmployeeManagementPage extends StatefulWidget {
  final int leaveId;

  EmployeeManagementPage({required this.leaveId});

  @override
  _EmployeeManagementPageState createState() => _EmployeeManagementPageState();
}

class _EmployeeManagementPageState extends State<EmployeeManagementPage> {
  List<Map<String, String>> leaveData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLeaveData();
  }

  Future<void> fetchLeaveData() async {
    final url = Uri.parse('https://localhost:44333/api/TL_leave_Portals/Employee_Details?id=${widget.leaveId}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          leaveData = data.map((item) {
            return {
              'Leave_Reason': item['Leave_Reason']?.toString() ?? '',
              'ApproveDate': item['ApproveDate']?.toString() ?? '',
              'Reject_Reason': item['Reject_Reason']?.toString() ?? '',
              'Reject_Date': item['Reject_Date']?.toString() ?? '',
              'Transfer_Reason': item['Transfer_Reason']?.toString() ?? '',
              'Transfer_Date': item['Transfer_Date']?.toString() ?? '',
            };
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load leave data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching leave data: $e');
    }
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
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddLeaveRequestPage()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
            columns: [
              DataColumn(label: Text('Leave Reason')),
              DataColumn(label: Text('Approve Date')),
              DataColumn(label: Text('Reject Reason')),
              DataColumn(label: Text('Reject Date')),
            ],
            rows: leaveData.map((leave) {
              return DataRow(cells: [
                DataCell(Text(leave['Leave_Reason'] ?? '')),
                DataCell(Text(leave['ApproveDate'] ?? '')),
                DataCell(Text(leave['Reject_Reason'] ?? '')),
                DataCell(Text(leave['Reject_Date'] ?? '')),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class AddLeaveRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Leave Request'),
        backgroundColor: Color(0xFF3A57C4),
      ),
      body: Center(
        child: Text('Add Leave Request Page'),
      ),
    );
  }
}
