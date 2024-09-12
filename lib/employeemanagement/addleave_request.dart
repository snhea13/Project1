import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'leave_list.dart'; // Ensure this import matches your file structure

class AddLeaveRequestPage extends StatefulWidget {
  final int employeeId;

  AddLeaveRequestPage({required this.employeeId});

  @override
  _AddLeaveRequestPageState createState() => _AddLeaveRequestPageState();
}

class _AddLeaveRequestPageState extends State<AddLeaveRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  String leaveType = '';
  final leaveReasonController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  final documentController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final body = json.encode({
        "Agent_Name": nameController.text,
        "LeaveType": leaveType,
        "Leave_Reason": leaveReasonController.text,
        "FromDate": fromDate?.toIso8601String(),
        "TODate": toDate?.toIso8601String(),
        "Document": documentController.text,
        "EmployeeId": widget.employeeId, // Include EmployeeId in the request
      });

      final url = 'https://employeemanagement.thedigitalindia.com/api/AgentLeaveApi/RequestForLeave';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: body,
        );

        if (response.statusCode == 200 || response.statusCode == 302) {
          print('Response data: ${response.body}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgentsRequestListPage(widget.employeeId),
            ),
          );
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Leave Request'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Leave Type'),
                  value: leaveType.isEmpty ? null : leaveType,
                  items: const [
                    DropdownMenuItem(value: 'Planned', child: Text('Planned')),
                    DropdownMenuItem(value: 'Unplanned', child: Text('Unplanned')),
                    DropdownMenuItem(value: 'Work From Home', child: Text('Work From Home')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      leaveType = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a leave type';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: leaveReasonController,
                  decoration: InputDecoration(labelText: 'Leave Reason'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the reason for leave';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'From',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            fromDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ),
                  controller: TextEditingController(
                    text: fromDate == null ? '' : fromDate!.toLocal().toString().split(' ')[0],
                  ),
                  validator: (value) {
                    if (fromDate == null) {
                      return 'Please select a start date';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'To',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            toDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ),
                  controller: TextEditingController(
                    text: toDate == null ? '' : toDate!.toLocal().toString().split(' ')[0],
                  ),
                  validator: (value) {
                    if (toDate == null) {
                      return 'Please select an end date';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: documentController,
                  decoration: InputDecoration(labelText: 'Documents'),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Send Leave Request'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
