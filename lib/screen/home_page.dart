import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterrecipeapp/screen/widget/search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe app'),
      ),
      body: Column(
        children: <Widget>[
           SearchBar(context),


        ],
      ),
    );
  }
}
