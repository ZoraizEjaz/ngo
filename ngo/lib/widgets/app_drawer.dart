import 'package:flutter/material.dart';


class AppDrawer extends StatelessWidget{
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('MilKar'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
        ],
      ),
    );


  }

}