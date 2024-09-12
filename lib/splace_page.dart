import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/employeemanagement/addleave_request.dart';
import 'package:untitled/employeemanagement/dashboard.dart';
import 'package:untitled/login_page.dart';

class SplaceScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>SplaceScreenState();
}

class SplaceScreenState extends State<SplaceScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace `NextScreen` with your target screen widget
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(child: Text('DITPL',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
      ),
    );

  }

  /*void wheretoGo() async{
    var sharepref =await SharedPreferences.getInstance();
    var isLoggedIn = sharepref.getBool(KEYLOGIN);
    Timer(Duration(seconds: 4),(){
      if(isLoggedIn!=null){
        if(isLoggedIn){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BMIcalculate(),
          ));
        }else
        {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage(),
          ));
        }
      }else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage(),
        ));
      }

    });

  }*/
}