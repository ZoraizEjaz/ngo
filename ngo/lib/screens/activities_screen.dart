import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ActivitiesScreen extends StatefulWidget{
  static const routeName = 'activities';
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Home'),
     ),
     drawer: AppDrawer(),
   );
  }

}
