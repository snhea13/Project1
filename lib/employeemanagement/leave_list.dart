import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    int? get employeeId => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leave Request List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AgentsRequestListPage(employeeId!),
    );
  }
}

class AgentsRequestListPage extends StatefulWidget {
  final int employeeId;

  const AgentsRequestListPage(this.employeeId);

  @override
  _AgentsRequestListPageState createState() => _AgentsRequestListPageState();
}

class _AgentsRequestListPageState extends State<AgentsRequestListPage> {
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  List<dynamic> leaveRequests = []; // To hold the leave requests
  get employeeid => null;

  @override
  void initState() {
    super.initState();
    _fetchLeaveRequests(); // Fetch the leave requests when the page loads
  }

  Future<void> _fetchLeaveRequests() async {
    // Construct the API URL
    String apiUrl = 'https://employeemanagement.thedigitalindia.com/api/TL_Leave_Portals/Agent_LRequestLists?'
        'fromDate=${selectedFromDate != null ? DateFormat('yyyy-MM-dd').format(selectedFromDate!) : ''}'
        '&toDate=${selectedToDate != null ? DateFormat('yyyy-MM-dd').format(selectedToDate!) : ''}'
        '&displayLength=10&displayStart=0&sortCol=1&sortDir=asc&userid=${widget.employeeId}&search=';

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          leaveRequests = json.decode(response.body); // Assuming the response is a JSON array
        });
      } else {
        print('Failed to load leave requests. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching leave requests: $e');
    }
  }

  void _search() {
    _fetchLeaveRequests(); // Re-fetch the leave requests with updated dates
  }

  void _clear() {
    fromDateController.clear();
    toDateController.clear();
    setState(() {
      selectedFromDate = null;
      selectedToDate = null;
      leaveRequests = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle headerTextStyle = TextStyle(
        color: Colors.black, // Set the desired color here
        fontSize: 16,
        fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: Text('Agents Request List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: fromDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'From Date',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, fromDateController, selectedFromDate),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: toDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'To Date',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, toDateController, selectedToDate),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _search,
                      child: Text('Search'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Set the background color here
                        padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding as needed
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _clear,
                      child: Text('Clear'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700, // Set the background color here
                        padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding as needed
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Agent Name', style: headerTextStyle)),
                    DataColumn(label: Text('Leave Type', style: headerTextStyle)),
                    DataColumn(label: Text('Document', style: headerTextStyle)),
                    DataColumn(label: Text('Status', style: headerTextStyle)),
                  ],
                  rows: leaveRequests.map<DataRow>((request) {
                    return DataRow(
                      cells: [
                        DataCell(
                          InkWell(
                            /*onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmployeeManagementPage(
                                    leaveId: request['Leave_Id'], // Pass the Leave_Id to EmployeeManagementPage
                                  ),
                                ),
                              );
                            },*/
                            child: Text(
                              request['Agent_Name'], // Replace with the correct key for agent name
                              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        DataCell(Text(request['LeaveType'])), // Replace with the correct key for leave type
                        DataCell(ElevatedButton(
                          onPressed: () => _showDocumentDialog(context, request['Document']), // Replace with the correct key for document
                          child: Text('View'),
                        )),
                        DataCell(Text(request['Actions'])), // Replace with the correct key for status
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDocumentDialog(BuildContext context, String document) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Document'),
          content: Text('Content of $document'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller, DateTime? initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
        if (controller == fromDateController) {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
      });
    }
  }
}

/*class EmployeeManagementPage extends StatelessWidget {
  final int leaveId;

  EmployeeManagementPage({required this.leaveId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Details'),
      ),
      body: Center(
        child: Text('Displaying details for Leave ID: $leaveId'),
      ),
    );
  }
}
*/