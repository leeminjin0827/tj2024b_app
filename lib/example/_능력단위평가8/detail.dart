import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget{
  @override
  _DetailState createState(){
    return _DetailState();
  }
} // c end
class _DetailState extends State<Detail>{
  int? bno;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bno ??= ModalRoute.of(context)!.settings.arguments as int;
    print( bno );
    bookFindBno( bno! );
    reviewView( bno! );
  } // did end

  Dio dio = Dio();
  Map< String,dynamic > book = { };
  void bookFindBno( bno ) async {
    try{
      final response = await dio.get("http://192.168.40.88:8080/test8/book/view?bno=$bno");
      final data = response.data;
      setState(() {
        book = data;
      });
      print( book );
    }catch(e) { print( e ); }
  } // findbno end

  // 리뷰 컨트롤러
  TextEditingController rcontentController = TextEditingController();
  TextEditingController rpasswordController = TextEditingController();

  // 리뷰 등록
  void reviewWrite() async {
    try{
      final sendData = {
        "bno" : bno,
        "rcontent" : rcontentController.text,
        "rpassword" : rpasswordController.text,
      };
      final response = await dio.post("http://192.168.40.88:8080/test8/review" , data: sendData );
      final data = response.data;
      if( data != null ) {
        reviewView(bno!); // 새로고침
        rcontentController.clear(); // 칸 비우기
        rpasswordController.clear();
      }
    }catch(e) { print( e ); }
  } // reviewWrite end

  // 리뷰 조회
  List< dynamic > reviewList = [];
  void reviewView( int bno ) async{
    try{
      final response = await dio.get("http://192.168.40.88:8080/test8/review?bno=$bno");
      final data = response.data;
      setState(() {
        reviewList = data;
      });
    }catch(e){print(e);}
  } // reviewView end

  // 리뷰 삭제
  void reviewDelete( int rno , String rpassword ) async{
    try{
      final response = await dio.delete("http://192.168.40.88:8080/test8/review?rno=$rno&rpassword=$rpassword");
      final data = response.data;
      print( data );
      if( data == true ){
        showCreate("삭제 성공");
        reviewView(bno!); 
      }else{
        showError("비밀번호가 일치하지 않습니다.");
      }
    }catch(e){ print(e); }
  } // 리뷰 삭제 end

  // 비밀번호 입력 창
  void showDelete( int rno ){
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
                  int? rpassword = int.tryParse(passwordController.text);
                  if( rpassword != null ){
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                    reviewDelete(rno, rpassword.toString()); // 삭제 실행
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("상세 화면"),),
      body: Center(
        child: Column(
          children: [
            Text("등록일: ${book['createAt']}" , style: TextStyle( fontSize: 25),),
            SizedBox( height: 10 ,),

            Text("수정일: ${book['updateAt']}" , style: TextStyle( fontSize: 25),),
            SizedBox( height: 10 ,),

            Text("제목: ${book['btitle']}" , style: TextStyle( fontSize: 25),),
            SizedBox( height: 10 ,),

            Text("저자: ${book['bname']}" , style: TextStyle( fontSize: 25),),
            SizedBox( height: 10 ,),

            Text("책소개: ${book['bcontent']}" , style: TextStyle( fontSize: 25),),
            SizedBox( height: 10 ,),

            TextField(
              controller: rcontentController,
              decoration: InputDecoration( labelText: "댓글내용"),
              maxLines: 2,
            ),
            TextField(
              controller: rpasswordController,
              decoration: InputDecoration( labelText: "비밀번호"),
            ),
            SizedBox( height: 5),
            OutlinedButton(onPressed: reviewWrite, child: Text("등록하기")),
            
            Expanded(
                child: reviewList.isEmpty
                    ? Center( child: Text("등록된 리뷰가 없습니다."))
                    : ListView.builder(
                    itemCount: reviewList.length,
                    itemBuilder: (context , index ){
                      final review = reviewList[index];
                      return ListTile(
                        title: Text(review['rcontent'] ?? ''),
                        subtitle: Text("작성일 ${review['createAt'] ?? ''}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton(onPressed: ()=>{showDelete( review['rno'] ) }, child: Text("삭제"))
                          ],
                        ),
                      );
                    }
                )
            )
          ],
        ),
      ),  
    );
  } // build end
} // c end