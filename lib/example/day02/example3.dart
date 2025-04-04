void main(){

  int number = 31;
  if( number % 2 == 1 ){
    print("[1]홀수!");
  }else{
    print("[1]짝수!");
  } // if end

  String light = "red";
  if( light == "green" ){
    print("[2]초록불!");
  }else if( light == "yellow" ){
    print("[2]노란불!");
  }else if( light == "red" ){
    print("[2]빨간불!");
  }else{
    print("[2]잘못된 신호입니다!");
  } // if end

  String light2 = "purple";
  if( light2 == "green" ){
    print("[3]초록불!");
  }else if( light2 == "yellow" ){
    print("[3]노랑불!");
  }else if( light2 == "red" ){
    print("[3]빨간불!");
  } // if end

  for( int i = 0; i < 100; i++ ){
    print(i+1);
  } // for end

  List<String> subjects = ["자료구조" , "이산수학" , "알고리즘" , "플러터" ];
  for( String subject in subjects ){
    print(subject);
  } // for end

  int i = 0;
  while( i < 100 ){
    print(i+1);
    i = i + 1;
  } // while end

  // int i2 = 0;
  // while( true ){
  //   print(i+1);
  //   i = i + 1;
  // } // while end
  
  int i3 = 0;
  while( true ){
    print(i3+1);
    i3 = i3 + 1;
    if( i3 == 100 ){
      break;
    } // if end
  } // while end

  for( int i = 0; i < 100; i++ ){
    if( i % 2 == 0 ){
      continue;
    }
    print(i+1);
  } // for end

  int add( int a , int b ){
    return a + b;
  }
  int number2 = add( 1 , 2 );
  print( number2 );

  switch(number){
    case 1:
      print( 'one' );
  }

  // const a5 = 'a';
  // const b5 = 'b';
  // switch(obj){
  //   case[ a5 , b5 ]:
  //     print('$a5,$b5');
  // }

  // switch(obj){
  //   // Matches if 1 == obj.
  //   case 1:
  //     print('one');

  //   // Matches if the value of obj is between the constant values of 'first' and 'lase'.
  //   case >= first && last:
  //     print('in range');
    
  //   // Matches if obj if a record with two fields , then assigns the fields to 'a' and 'b'.
  //   case ( var a , var b ):
  //     print(' a = $a , b = $b' );

  //   default:
  // } // switch end


} // main end