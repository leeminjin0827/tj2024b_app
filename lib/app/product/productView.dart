import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductView extends StatefulWidget{ // [부모위젯]

  // (1) 하나의 필드를 갖는 생성자.
  /*
    int pno; // - 필드/멤버변수
    ProductView( this.pno ); // 생성자
  */
  // 오버로딩 지원하지 않는다. : 여러개 생성자를 가질 수 없다.

  // (2) * 여러개의 필드를 갖는 생성자 *
  int? pno; // 타입? : null 포함한다 뜻
  String? pname;
  ProductView( { this.pno , this.pname } );

  @override
  State<StatefulWidget> createState() {
    // print( pno ); // [확인용]
    return _ProductViewState();
  } // createState end
} // c end

class _ProductViewState extends State<ProductView>{ // [자식위젯]

  // 1.
  Map<String , dynamic> product = {}; // 제품 1개를 저장하는 상태변수.
  final dio = Dio();
  final String baseUrl = "http://192.168.40.88:8080"; // 환경에 따라 변경
  bool isOwner = false; // 현재 로그인된 회원이 등록한 제품인지 확인 변수

  // 2. 생명주기
  @override // (1) pno에 해당 하는 제품 정보 요청
  void initState() { onView(); }

  // 3. 제품 요청
  void onView() async {
    try{  // * 직계상위 부모위젯에 접근 : widget.필드명 , widget.메소드명()
      final response = await dio.get("$baseUrl/product/view?pno=${ widget.pno }");
      if( response.data != null ){
        setState(() {
          product = response.data; print( product ); // print 확인시 -> 웹:F12개발자도구 , 에뮬레이터 : 콘솔
        });
        // * 현재 로그인된 회원
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
        if( token == null ){ setState(() { isOwner = false; }); return; } // 비로그인중이면 리턴
        // * 토큰 보내서 토큰의 회원정보 요청
        dio.options.headers['Authorization'] = token; // token 포함
        final response2 = await dio.get("${baseUrl}/member/info"); // 요청
        if( response2.data['memail'] == response.data['memail'] ){ // 회원정보의 아이디 와 제품의 등록회원아이디와 같으면
          setState(() { isOwner == true; }); // 현재 로그인된 회원이 내가 등록한제품을 본다.
        } // if end
      } // if end
    }catch(e) { print( e ); }
  } // onView end

  // 5. 삭제 요청 함수 , pno : 삭제할 제품번호
  void onDelete( pno ) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if( token == null ) { return; }
      dio.options.headers['Authorization'] = token;
      final response = await dio.delete("${baseUrl}/product/delete?pno=${pno}");
      if( response.data == true ){
        print("삭제성공");
      } // if end
    }catch(e){ print( e ); }
  } // onDelete end

  // 4. 화면 반환
  @override
  Widget build(BuildContext context) {

    // 4-1. 만약에 제품정보가 없으면 로딩위젯( CircularProgressIndicator() )
    if( product.isEmpty ){ return Center( child: CircularProgressIndicator(),); }

    // 4-2. 이미지 추출
    final List<dynamic> images = product['images'];

    // 4-3. 이미지 상태에 따라 위젯 만들기
    Widget imageSection;
    if( images.isEmpty ){ // 이미지가 존재하지 않으면
      imageSection = Container(
        height: 300 , // 높이
        alignment: Alignment.center, // 가운데정렬
        child: Image.network( "$baseUrl/upload/default.jpg" , fit: BoxFit.cover ,),
      );
    }else{ // 이미지들이 존재하면
      imageSection = Container(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal , // 목록 스크롤 방향 , 기본값:세로 , 가로 설정(Axis.horizontal)
          itemCount: images.length, // 이미지 개수 반복
          itemBuilder: (context , index ){
            String imageUrl = "$baseUrl/upload/${images[index]}"; // index번째 이미지
            return Padding(
              padding: EdgeInsets.all( 5 ),
              child: Image.network( imageUrl , fit: BoxFit.cover,),
            );
          }, // itemBuilder end
        ),
      );
    } // if end

    return Scaffold(
      appBar: AppBar(
        title: Text("제품 상세 정보"),
      ),
      // 3. 본문
      body: SingleChildScrollView( // 내용이 길어지면 스크롤 제공하는 위젯
        padding: EdgeInsets.all( 10 ) ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            /* 이미지 위젯 */
            imageSection,
            /* 이미지 위젯 end */
            SizedBox( height: 20 ,),
            Text( product['pname'] , style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold), ),
            SizedBox( height: 15 ,),
            Text( "${product['pprice']}원" , style: TextStyle( fontSize:  22, fontWeight: FontWeight.bold , color: Colors.red ), ),
            SizedBox( height: 10 ,),
            Divider() , // 구분선 : vs <hr/>
            SizedBox( height: 10 ,),
            Row( // 가로 배치
              mainAxisAlignment: MainAxisAlignment.spaceBetween , // 양쪽 끝에 배치
              children: [
                Text( "카테고리 : ${product['cname'] }" ),
                Text( "조회수 : ${product['pview'] }" ),
              ],
            ),
            SizedBox( height: 10,),
            Text( "작성자 : ${product['memail'] }" ),
            SizedBox( height: 15,),
            Text("제품 설명" , style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ),),
            SizedBox( height: 8,),
            Text( product['pcontent'] ),
            /* 만약에 isOwner 가 true 이면 로그인된 회원의 제품  */
            if( isOwner )
              Row(
                children: [
                  ElevatedButton(onPressed: () => {} , child: Text("수정")),
                  ElevatedButton(onPressed: () => { onDelete( product['pno'] ) } , child: Text("삭제")),
                ],
              )
          ],
        ),
      ), 
    );
  } // build end
} // c end