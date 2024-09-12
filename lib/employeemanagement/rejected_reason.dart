import 'package:flutter/material.dart';

class LeavePage extends StatelessWidget {
  final List<Leave> leaves = [
    Leave(leaveReason: 'Medical Leave', fromDate: '2023-08-10', toDate: '2023-08-15', rejectedDate: '2023-08-09'),
    // Add more leaves as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaves'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Leave Reason')),
                  DataColumn(label: Text('From Date')),
                  DataColumn(label: Text('To Date')),
                  DataColumn(label: Text('Rejected Date')),
                ],
                rows: leaves.map((leave) {
                  return DataRow(
                    cells: [
                      DataCell(Text(leave.leaveReason)),
                      DataCell(Text(leave.fromDate)),
                      DataCell(Text(leave.toDate)),
                      DataCell(Text(leave.rejectedDate)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Leave {
  final String leaveReason;
  final String fromDate;
  final String toDate;
  final String rejectedDate;

  Leave({
    required this.leaveReason,
    required this.fromDate,
    required this.toDate,
    required this.rejectedDate,
  });
}

void main() {
  runApp(MaterialApp(
    home: LeavePage(),
  ));
}
