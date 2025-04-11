
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState(){
    return _HomeState();
  }
} // c end

class _HomeState extends State<Home>{
  Dio dio = Dio();
  List< dynamic > booklist = [];
  void bookFindAll() async{
    try{
      final response = await dio.get("http://192.168.40.88:8080/test8/book");
      final data = response.data;
      setState(() {
        booklist = data;
      });
      print( booklist );
    }catch(e) { print( e ); }
  }
  // 최초 1회 실행
  @override
  void initState() {
    super.initState();
    bookFindAll();
  }

  // 비밀번호 입력 창
  void showDelete( int bno ){
    TextEditingController passwordController = TextEditingController();
    
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("비밀번호 확인"),
            content: TextField(
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "비밀번호 입력"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 닫기
                  },
                  child: Text("취소"),
              ),
              TextButton(
                  onPressed: () {
                    int? pw = int.tryParse(passwordController.text);
                    if( pw != null ){
                      Navigator.of(context).pop(); // 다이얼로그 닫기
                      bookDelete(bno, pw); // 삭제 실행
                    }else{
                    }
                  },
                  child: Text("삭제"),
              )
            ],
          );
        }
    );
  } // 비밀번호 입력 창 end

  // 삭제 성공 알림창
  void showCreate( String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("삭제"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("확인"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        )
    );
  } // 삭제 성공 알림 창 end

  // 비밀번호 틀렸을 때 창
  void showError( String message ) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("오류"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("확인"),
              onPressed: ()=>Navigator.of(context).pop(),

            )
          ],
        )
    );
  } // 비밀번호 틀렸을 때 창 end

  // 삭제 이벤트 함수
  void bookDelete( int bno , int bpassword ) async{
    try{
      final response = await dio.delete("http://192.168.40.88:8080/test8/book?bno=$bno&bpassword=$bpassword");
      final data = response.data;
      if( data == true ) {
        showCreate("삭제 성공");
        bookFindAll();
      }
      else{ showError("비밀번호가 일치하지 않습니다."); }
      }catch(e) { print( e ); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title : Text("메인페이지 : TEST8"),),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: ()=>{ Navigator.pushNamed(context, "/write")},
              child: Text("책등록")
            ), // TextButton end
            Expanded(
                child: ListView(
                  children: booklist.map( (book) {
                    return Card( child: ListTile(
                      title: Text( book['bno'].toString() ),
                      subtitle: Column(
                        children: [
                          Text("책제목 : ${book['btitle'] }" ),
                          Text("책저자 : ${book['bname'] }" ),
                          Text("책소개 : ${book['bcontent'] }" ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize:  MainAxisSize.min,
                        children: [
                          IconButton(onPressed: ()=>{Navigator.pushNamed(context, "/update",arguments: book['bno'] ) }, icon: Icon(Icons.edit)),
                          IconButton(onPressed: ()=>{Navigator.pushNamed(context, "/detail",arguments: book['bno'] ) }, icon: Icon(Icons.info)),
                          IconButton(onPressed: ()=>{showDelete( book['bno'] ) }, icon: Icon(Icons.delete)),
                        ],
                      ),
                    ),);
                  } ).toList(),
                )
            )
          ],
        ),
      ),
    ); // scaffold end
  } // build end
} // c end