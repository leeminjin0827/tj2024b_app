import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget{
  @override
  _DetailState createState(){
    return _DetailState();
  }
} // c end
class _DetailState extends State<Detail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( title: Text("상세 화면"),),
    );
  }
} // c end