import 'package:flutter/material.dart';
import 'package:ngo/screens/activities_screen.dart';
import 'package:ngo/screens/register_screen.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        ActivitiesScreen.routeName: (ctx) => ActivitiesScreen(),
      },

    );
  }
}

