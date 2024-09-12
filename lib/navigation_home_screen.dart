import 'package:flutter/material.dart';
import 'package:untitled/app_theme.dart';
import 'package:untitled/custom_drawer/drawer_user_controller.dart';
import 'package:untitled/employeemanagement/addleave_request.dart';
import 'package:untitled/employeemanagement/agent_portal.dart';
import 'package:untitled/employeemanagement/approved_list.dart';
import 'package:untitled/employeemanagement/dashboard.dart';
import 'package:untitled/employeemanagement/leave_list.dart';
import 'package:untitled/employeemanagement/reject_list.dart';
import 'package:untitled/login_page.dart';
import 'package:untitled/main.dart';
import 'package:untitled/employeemanagement/approved_list.dart';
import 'package:untitled/home_screen.dart';
import 'package:untitled/home_drawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  final int? employyeID; // Add this field to pass the employee ID

  NavigationHomeScreen({Key? key, this.employyeID}) : super(key: key);

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage(title: 'title'); // Ensure this is correctly imported and used
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = HomePage();
          });
          break;
        case DrawerIndex.LeaveRequest:
          if (widget.employyeID != null) {
            setState(() {
              screenView = AddLeaveRequestPage(employeeId: widget.employyeID!);
            });
          } else {
            showErrorPage();
          }
          break;
        case DrawerIndex.Profile:
          if (widget.employyeID != null) {
            setState(() {
              screenView = AgentsRequestListPage(widget.employyeID!);
            });
          } else {
            showErrorPage();
          }
          break;
        case DrawerIndex.Invite:
          if (widget.employyeID != null) {
            setState(() {
              screenView = AgentsApproveListPage(employeeId: widget.employyeID!);
            });
          } else {
            showErrorPage();
          }
          break;
        case DrawerIndex.RejectList:
          if (widget.employyeID != null) {
            setState(() {
              screenView = AgentsRejectListPage(employeeId: widget.employyeID!);
            });
          } else {
            showErrorPage();
          }
          break;
        default:
          setState(() {
            screenView = NewScreenView();
          });
          break;
      }
    }
  }

  void showErrorPage() {
    setState(() {
      screenView = ErrorPage("Employee ID is not available.");
    });
  }

}

class NewScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Screen'),
      ),
      body: Center(
        child: Text('This is the new screen view'),
      ),
    );
  }
}


class ErrorPage extends StatelessWidget {
  final String message;

  ErrorPage(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
