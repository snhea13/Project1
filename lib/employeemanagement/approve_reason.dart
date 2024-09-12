import 'package:flutter/material.dart';
import 'package:untitled/employee management/addleave_request.dart';

import 'addleave_request.dart';

void main() => runApp(ApprovedReason());

class ApprovedReason extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ApproveReasonPage(),
    );
  }
}

class ApproveReasonPage extends StatelessWidget {
  get employyeId => null;

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
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaves'),
        backgroundColor: Color(0xFF3A57C4),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddLeaveRequestPage(employeeId: employyeId ),
                ),
              );
              // Navigate to Add Leave Request page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Leave Reason', style: TextStyle(color: Colors.blue))),
                    DataColumn(label: Text('From Date', style: TextStyle(color: Colors.blue))),
                    DataColumn(label: Text('To Date', style: TextStyle(color: Colors.blue))),
                    DataColumn(label: Text('Status', style: TextStyle(color: Colors.blue))),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Sick Leave')),
                      DataCell(Text('19-8-24')),
                      DataCell(Text('19-8-24')),
                      DataCell(Text('Approved')),
                    ]),
                    // Add more rows as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
