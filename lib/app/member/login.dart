import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tj2024b_app/app/layout/mainapp.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  } // createState end
} // c end
class _LoginState extends State<Login>{
  // 입력상자 컨트롤러
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  // 로그인 버튼 클릭시
  void onLogin() async {
    try{
      final sendData = {
        'memail' : emailController.text,
        'mpwd' : pwdController.text,
      }; print( sendData );
      Dio dio = Dio();
      final response = await dio.post( "http://localhost:8080/member/login", data: sendData );
      final data = response.data;
      if( data != '' ){ // 로그인 성공시 토큰 SharedPreferences 저장하기.
        // 1. 전역변수 호출
        final prefs = await SharedPreferences.getInstance();
        // 2. 전역변수 값 추가
        await prefs.setString( 'token' , data );

        // * 로그인 성공시 페이지 전환
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainApp() ),
        );
      }else{
        print("로그인 실패");
      }
    }catch(e) { print( e ); }
  } // onLogin end

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 레이아웃 위젯
      body: Container( // 여백 제공하는 박스 위젯
        padding: EdgeInsets.all(30), // 박스 안쪽 여백
        margin: EdgeInsets.all(30), // 박스 바깥 여백
        child: Column( // 하위 요소 세로 위젯
          mainAxisAlignment: MainAxisAlignment.center, // 현재 축(Column) 기준으로 정렬
          children: [ // 하위 요소를 위젯
            TextField(
              controller: emailController,
              decoration: InputDecoration( labelText: "이메일" , border: OutlineInputBorder() ),
            ),
            SizedBox( height: 20, ),
            TextField(
              controller: pwdController,
              obscureText: true, // 입력값 감추기
              decoration: InputDecoration( labelText: "비밀번호" , border: OutlineInputBorder() ),
            ),
            SizedBox( height: 20 ,),
            ElevatedButton(onPressed: onLogin , child: Text("로그인") ),
            SizedBox( height: 20 ,),
            TextButton(onPressed: ()=>{}, child: Text("처음 방문이면 _회원가입") ),
          ],
        ),
      ), // Container end
    ); // Scaffold end
  } // build end
} // c end