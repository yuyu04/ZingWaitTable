import 'package:flutter/material.dart';
import 'package:zing_wait_table/src/ui/init_screen.dart';
import 'ui/login_widget.dart';
import 'ui/login_widget.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zing wait table',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: InitScreen(),
    );
  }
}