import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:untitled/employeemanagement/leave_details.dart';
import 'package:untitled/employeemanagement/reject_list.dart';
import 'package:untitled/employeemanagement/rejected_reason.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reject List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AgentsApproveListPage(employeeId: 12),
    );
  }
}
/*Future<int> getEmployeeId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('employeeId') ?? 0; // Return a default value if not found
}

class SharedPreferences {
  getInt(String s) {}

  static getInstance() {}
}*/
class AgentsApproveListPage extends StatelessWidget {
  final int employeeId;

  AgentsApproveListPage({required this.employeeId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approved List'),
      ),
      body: Center(
        child: Text('This is the Agents Approve List Page'),
      ),
    );
  }
}

class _AgentsRequestListPageState extends State<AgentsRejectListPage> {
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  List<Map<String, dynamic>> rejectedListData = [];
  bool isLoading = false;

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

  Future<void> _search() async {
    setState(() {
      isLoading = true;
    });

    final String fromDate = fromDateController.text;
    final String toDate = toDateController.text;

    final String url = 'https://employeemanagement.thedigitalindia.com/api/TL_Leave_Portals/Approved_Lists?fromDate=$fromDate&toDate=$toDate&displayLength=10&displayStart=0&sortCol=1&sortDir=asc&userid=12&search=';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          rejectedListData = data.map((item) => item as Map<String, dynamic>).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load rejected list');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching rejected list: $e');
    }
  }

  void _clear() {
    fromDateController.clear();
    toDateController.clear();
    setState(() {
      selectedFromDate = null;
      selectedToDate = null;
      rejectedListData = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle headerTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Agents Request List'),
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
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _clear,
                      child: Text('Clear'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              isLoading
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Agent Name', style: headerTextStyle)),
                    DataColumn(label: Text('Leave Type', style: headerTextStyle)),
                    DataColumn(label: Text('Document', style: headerTextStyle)),
                    DataColumn(label: Text('Status', style: headerTextStyle)),
                  ],
                  rows: rejectedListData.map((item) {
                    return DataRow(cells: [
                      DataCell(
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LeavePage(),
                            ),
                          ),
                          child: Text(
                            item['AgentName'] ?? '',
                            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      DataCell(Text(item['LeaveType'] ?? '')),
                      DataCell(ElevatedButton(
                        onPressed: () => _showDocumentDialog(context, item['Document'] ?? 'No Document'),
                        child: Text('View'),
                      )),
                      DataCell(Text(item['Status'] ?? 'Rejected')),
                    ]);
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
}
