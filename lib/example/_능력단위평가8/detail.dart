import 'package:dio/dio.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    int bno = ModalRoute.of(context)!.settings.arguments as int;
    print(bno);
    bookFindBno( bno );
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
          ],
        ),
      ),  
    );
  } // build end
} // c end