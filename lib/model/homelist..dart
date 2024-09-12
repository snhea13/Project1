/*import 'package:best_flutter_ui_templates/design_course/home_design_course.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';
import 'package:best_flutter_ui_templates/hotel_booking/hotel_home_screen.dart';
import 'package:best_flutter_ui_templates/introduction_animation/introduction_animation_screen.dart';*/
import 'package:flutter/widgets.dart';
import 'package:untitled/employeemanagement/addleave_request.dart';
import 'package:untitled/employeemanagement/leave_list.dart';
import 'package:untitled/login_page.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/introduction_animation/introduction_animation.png',
      navigateScreen: AddLeaveRequestPage(employeeId: employeeId,),
    ),
    HomeList(
      imagePath: 'assets/hotel/hotel_booking.png',
      navigateScreen: AgentsRequestListPage(employeeId),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/fitness_app.png',
      navigateScreen: LoginPage(),
    ),
    /*HomeList(
      imagePath: 'assets/design_course/design_course.png',
      navigateScreen: DesignCourseHomeScreen(),
    ),*/
  ];

  static get employeeId => null;
}