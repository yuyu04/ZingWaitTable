import 'package:flutter/material.dart';
import 'ui/movie_list.dart';

class App extends StatefulWidget {

  App({Key key, this.api}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<SearchApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RxDart Github Search',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: SearchScreen(api: widget.api),
    );
  }
}