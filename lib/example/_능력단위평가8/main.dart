import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/_%EB%8A%A5%EB%A0%A5%EB%8B%A8%EC%9C%84%ED%8F%89%EA%B0%808/detail.dart';
import 'package:tj2024b_app/example/_%EB%8A%A5%EB%A0%A5%EB%8B%A8%EC%9C%84%ED%8F%89%EA%B0%808/home.dart';
import 'package:tj2024b_app/example/_%EB%8A%A5%EB%A0%A5%EB%8B%A8%EC%9C%84%ED%8F%89%EA%B0%808/update.dart';
import 'package:tj2024b_app/example/_%EB%8A%A5%EB%A0%A5%EB%8B%A8%EC%9C%84%ED%8F%89%EA%B0%808/write.dart';

void main(){
  runApp(MyApp() );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/" : (context) => Home(),
        "/write" : (context) => Write(),
        "/update" : (context) => Update(),
        "/detail" : (context) => Detail(),
      },
    ); // MaterialApp end
  } // build end
} // class end