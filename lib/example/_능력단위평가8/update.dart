import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget{
  @override
  _UpdateState createState(){
    return _UpdateState();
  }
} // c end
class _UpdateState extends State<Update>{

  // 매개변수 가져오기
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int bno = ModalRoute.of(context)!.settings.arguments as int;
    print(bno);
    bookFindById(bno);
  } // f end
  
  // 서버 통신
  Dio dio = Dio();
  Map<String , dynamic> book = {};
  void bookFindById( int bno ) async{
    try{
      final response = await dio.get("http://192.168.40.88:8080/test8/book/view?bno=$bno");
      final data = response.data;
      setState(() {
        book = data;
        titleController.text = data['btitle'];
        nameController.text = data['bname'];
        contentController.text = data['bcontent'];
      });
    }catch(e) { print( e ); }
  }

  // 입력 컨트롤러
  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void bookUpdate() async {
    try{
      final sendData = {
        "bno" : book['bno'],
        "btitle" : titleController.text,
        "bname" : nameController.text,
        "bcontent" : contentController.text,
        "bpassword" : passwordController.text,
      };
      print(sendData);
      final response = await dio.put("http://192.168.40.88:8080/test8/book" , data: sendData );
      final data = response.data;
      if( data != null ){
        Navigator.pushNamed(context, "/" );
      }
    }catch(e){ print(e); }
  }

  // ===============================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("책 수정"),),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration( labelText: "제목"),
              maxLength: 30,
            ),
            SizedBox( height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration( labelText: "저자"),
              maxLength: 30,
            ),
            SizedBox( height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration( labelText: "소개"),
              maxLines: 2,
            ),
            SizedBox( height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration( labelText: "비밀번호"),
              maxLines: 2,
            ),
            SizedBox( height: 20),
            OutlinedButton(onPressed: bookUpdate , child: Text("수정하기"))
          ],
        ),
      ),
    );
  }
} // c end