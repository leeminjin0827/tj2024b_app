import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null) {
      try {
        int bno = int.parse(args.toString());
        print("넘어온 bno: $bno");
        bookFindById(bno);
      } catch (e) {
        print("에러: arguments는 있지만 int로 변환 불가 - $e");
      }
    } else {
      print("에러: arguments가 null임");
    }
  }
  
  // 서버 통신
  Dio dio = Dio();
  Map<String , dynamic> book = {};
  void bookFindById( int bno ) async{
    try{
      final response = await dio.get("http://192.168.40.88:8080/tast8/book/view?bno=$bno");
      final data = response.data;
      setState(() {
        book = data;
        titleController.text = data['btitle'];
        nameController.text = data['bname'];
        contentController.text = data['bcontent'];
        done = data['done'];
      });
    }catch(e) { print( e ); }
  }

  // 입력 컨트롤러
  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool done = true;
  // 입력 컨트롤러

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
            Text("완료 여부"),
            Switch(
                value: done,
                onChanged: (value)=>{ setState(() { done = value; }) },
            ),
            SizedBox( height: 20),
            OutlinedButton(onPressed: ()=>{}, child: Text("수정하기"))
          ],
        ),
      ),
    );
  }
} // c end