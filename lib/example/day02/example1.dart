void main(){
  /* 
    var info = userInfo(json);
    var name = info.$1;
    var age = info.$2;
  */

  // 연산자
  // + (숫자)덧셈 (문자열)병합
  int a = 2;
  int b = 1;
  print( a + b ); // 3
  
  String firstName = 'Jeongjoo';
  String lastName = 'Lee';
  String fullName = lastName + ' ' + firstName;
  // 'Lee Jeongjoo'

  // - 뺄셈
  int a1 = 2;
  int b1 = 1;
  print( a1 - b1 ); // 1

  // -표현식 / 부호를 뒤집음 / 양수 <-> 음수
  int a2 = 2;
  print( -a2 ); // -2

  // * 곱셈
  int a3 = 6;
  int b3 = 3;
  print( a3 * b3 ); //18
  print( '*' * 5 ); // '*****'

  // / 나눗셈
  int a4 = 10;
  int b4 = 4;
  print( a4 / b4 ); // 2.5

  // ~/ 나눗셈의 몫
  int a5 = 10;
  int b5 = 4;
  print( a5 ~/ b5 ); // 2

  // % 나눗셈의 나머지
  int a6 = 10;
  int b6 = 4;
  print( a6 % b6 ); // 2

  // ++변수 변수에 1더함 선반영
  int a7 = 0;
  print(++a7); // 1
  print(a7); // 1

  // 변수++ 변수에 1더함 후반영
  int a8 = 0;
  print(a8++); // 0
  print(a8); // 1

  // --변수 변수에 1뺌 선반영
  int b9 = 1;
  print( --b9 ); // 0
  print( b9 ); // 0

  // 변수-- 변수에 1뺌 후반영
  int b10 = 1;
  print( b10-- ); // 1
  print( b10 ); // 0

  // == 두 값이 같은지 비교
  int a11 = 2;
  int b11 = 1;
  print( a11 == b11 ); // false

  // != 두 값이 다른지 비교
  int a12 = 2;
  int b12 = 1;
  print( a12 != b12 ); // true

  // > 왼쪽이 클경우 true
  int a13 = 2;
  int b13 = 1;
  print( a13 > b13 ); // true

  // < 왼쪽이 작을경우 true
  int a14 = 2;
  int b14 = 1;
  print(a14 < b14); // false

  // >= 왼쪽이 크거나 같을경우 true
  int a15 = 2;
  int b15 = 1;
  print( a15 >= b15); // true

  // <= 왼족이 크거나 같을경우 true
  int a16 = 2;
  int b16 = 2;
  print( a16 <= b16 ); // true

  // = 값을 재할당
  int a17 = 1; // 할당
  print( a17 ); // 1
  a17 = 2; // 재할당
  print( a17 ); // 2

  // += , -= , *= 등 사칙연산 이후 재할당
  // a18 *= 3; // a18 = a18 * 3 

  // !표현식 표현식의 결과 뒤집음 true <-> false 
  int a19 = 2;
  int b19 = 1;
  bool result = a19 > b19; // true
  print( !result ); // false

  // || 이거나 하나라도 true
  int a20 = 3;
  int b20 = 2;
  int c20 = 1;
  print( a20 > b20 ); // true
  print( b20 < c20 ); // false
  print( a20 > b20 || b20 < c20 ); // true

  // && 그리고 모두 true
  int a21 = 3;
  int b21 = 2;
  int c21 = 1;
  print( a21 > b21 ); // true
  print( b21 < c21 ); // false
  print( a21 > b21 && b21 <c21 ); // false


} // main end



