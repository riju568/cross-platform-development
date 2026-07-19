// https://docs.flutter.dev/install/custom --> SDK with code editor and IDE
// https://youtu.be/Ej_Pcr4uC2Q --> complete tutorial

import 'dart:io';



class Num {
  int num = 10;
}

int notEqual() {
  var n = Num();
  int number220;
  number220 = n.num ?? 0;
  print(number220);
  return 0;
}

void main() {

  print("Hello World");
  var firstName = 'Mahmud';
  String lastName = 'A';

  print(firstName + ' ' + lastName);
  print(firstName + ' ' + lastName); 

  stdout.writeln("What is your name?");

  int amount1 = 100;
  int amount2 = 200;
  print('amount1: $amount1 | Amount2: $amount2');

  double dAmount1 = 100.11; 
  var dAmount2 = 200.22;
  print('dAmount1: $dAmount1, dAmount2: $dAmount2');
  String name1 = 'Mahmid';
  var name22 = 'Ahsan'; // Fixed: Typo 'mane22' -> 'name22'
  print('Names: $name1, $name22');
  dynamic weakVariable = 100;
  print('weakVariable: $weakVariable\n');
  weakVariable = 'Dart programming';
  weakVariable = null;
  print('weakVariable: $weakVariable');

  var s1 = ' Single quotes work well';
  var s2 = " Double quotes work well";
  var s3 = "Hi it's working";
  print(s1);
  print(s2);
  print(s3);
  var s23 = r'In a raw string, not even \n gets special treatment';
  print(s23);

  var v1 = '''This is a multi-line string''';
  var v2 = '''This is also a multi-line string''';
  print(v1);
  print(v2);

  // String -> int
  var one = int.parse('1');
  assert(one == 1);

  // String -> double
  var onePointOne = double.parse('1.1');
  assert(onePointOne == 1.1);

  // int -> String
  String oneAsString = 1.toString();
  print('oneAsString: $oneAsString');

  // double -> String
  String piAsString = 3.14159.toStringAsFixed(2);
  assert(piAsString == '3.14');

  // const keyword
  const aConstNum = 0; // int constant
  const aConstBool = true; // bool constant
  const aConstString = 'a contract';
  print(aConstNum);
  print(aConstBool);
  print(aConstString);
  // Use .runtimeType instead of .runtime
  print(aConstNum.runtimeType);
  print(aConstBool.runtimeType);
  print(aConstString.runtimeType);
  int num12 = 0;
  print(num12);

  int num13 = 10 + 22;
  print(num13);

  // Relational operators
  if (num13 == 100) {
    print("num13 is 100");
  }

  num13 *= 2; // num13 = num13 * 2;
  print(num13);

  // Unary Operator
  ++num13;
  num13++;
  print(num13);
  num13++;
  num13 += 1;
  num13 -= 1;
  print(num13);
    //logical && logical || // and or
  if(num14>200 && num<203){
    print('200 to 203');
    //!= Not Equal
    if(num15 != 100){
      PRINT('Num is not equal to 100');
    }
  }
  

}
// != not Equal
if num16!= 100{
  print('num is not equal to 100');


   var n = Num();
  int number220;
  number220 = n.num ?? 0;
  print(number220);
  return 0;
}

void main() {
  notEqual();

  // Null Aware Operator
  int? number16;
  print(number16 ??= 100);
  print(number16);

  // Ternary Operator
  int x11 = 100;
  var result122 = x11 % 2 == 0 ? 'Even' : 'Odd';
  print(result122);

  // Type test
  var x123 = 100;
  if (x123 is int) {
    print('Integer');
  }

  // Conditional Statement
  int number124 = 100;
  if (number124 % 2 == 0) {
    print('Even');
  } else if (number124 % 2 != 0) {
    print('Odd');
  } else {
    print("Confused");
  }

  // Switch Statement
  int number134 = 0;
  switch (number134) { 
    case 0:
      print('Even');
      break;
    case 1: // lowercase 'case'
      print('Odd');
      break;
    default:
      print('Confused');
  }

  // For-in Loop
  var number146 = [1, 2, 3];
  for (var n in number146) { 
    print(n);
  }

  // While loop
  int number148 = 5;
  while (number148 > 0) {
    print(number148);
    number148 -= 1;
  }

  // Break and Continue
  for (var i = 0; i < 10; ++i) {
    if (i > 5) break; // Outof the loop
    print(i);
  }

  for (var i = 0; i < 10; ++i) {
    if (i % 2 == 0) continue; // Inside the loop
    print("odd: $i"); 
  }
}
  // List
  List<String> names149 = ['Jack', 'jaill'];
  print(names149);
  for (var n in names149) {
    print(n);
  }

  // Collection 
  List<String> name151 = ['hello', 'Fiends'];
  // Create a new list
  var names152 = [...name151]; 
  names152[1] = 'Mark';
  for (var n in names152) {
    print(n);
  }

  // Map
  // Use Map<KeyType, ValueType>() constructor or literal
  var gift221 = <String, String>{}; 
  print(gift221);
  gift221['first'] = 'Mego';
  print(gift221['first']); 
  var gift222 = {'first': 'Mango', 'second': 'Jack Friend'};
  print(gift222['second']);
}

