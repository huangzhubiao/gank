import 'package:flutter/material.dart';

class Mine extends StatefulWidget{
  _MineState  createState()=> _MineState();
}

class _MineState extends State<Mine>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('我的'),
      ),
      body: new Center(
        child: new Text('data'),
      ),
      );
  }

}