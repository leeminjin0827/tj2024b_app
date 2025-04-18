import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Write extends StatefulWidget{
  @override
  _WriteState createState(){
    return _WriteState();
  }
} // c end
class _WriteState extends State<Write>{
  final TextEditingController btitleController = TextEditingController();
  final TextEditingController bnameController = TextEditingController();
  final TextEditingController bcontentController = TextEditingController();
  final TextEditingController bpasswordController = TextEditingController();

  Dio dio = Dio();
  void bookWrite() async {
    try{
      final sendData = {
        "btitle" : btitleController.text,
        "bname" : bnameController.text,
        "bcontent" : bcontentController.text,
        "bpassword" : bpasswordController.text,
      };
      final response = await dio.post("http://192.168.40.88:8080/test8/book" , data: sendData );
      final data = response.data;
      if( data != null ){
        Navigator.pushNamed(context, "/" ); // 처음화면으로 이동
      } // if end
    }catch(e){ print(e); }
  } // write end


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("등록 화면"),),
      body: Center(
        child: Column(
          children: [
            SizedBox( height: 20 ,),
            TextField(
              controller: btitleController,
              decoration: InputDecoration( labelText: "책제목"),
              maxLength: 20,
            ),
            TextField(
              controller: bnameController,
              decoration: InputDecoration( labelText: "책저자"),
              maxLength: 20,
            ),
            TextField(
              controller: bcontentController,
              decoration: InputDecoration( labelText: "책소개"),
              maxLines: 2,
            ),
            TextField(
              controller: bpasswordController,
              decoration: InputDecoration( labelText: "비밀번호"),
              maxLength: 20,
            ),
            
            OutlinedButton(onPressed: bookWrite, child: Text("등록"), ),
          ],
        ),
      ),
    );
  }
} // c end