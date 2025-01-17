  import 'dart:io';
  //import 'package:best_flutter_ui_templates/app_theme.dart';
  //import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:untitled/app_theme.dart';
  import 'package:untitled/login_page.dart';
  //import 'firebase_options.dart';
  import 'navigation_home_screen.dart';
  //import 'model/firebase_api.dart';
  import 'package:flutter/foundation.dart' show kIsWeb;

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]).then((_) => runApp(MyApp()));
  }

class DefaultFirebaseOptions {
  static var currentPlatform;
}
  /*class DefaultFirebaseOptions {
    static var currentPlatform;
  }*/

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
        !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        //
      ));
      return MaterialApp(
        title: 'Flutter UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        home: LoginPage(),
      );
    }
  }

  class HexColor extends Color {
    HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

    static int _getColorFromHex(String hexColor) {
      hexColor = hexColor.toUpperCase().replaceAll('#', '');
      if (hexColor.length == 6) {
        hexColor = 'FF' + hexColor;
      }
      return int.parse(hexColor, radix: 16);
    }
  }