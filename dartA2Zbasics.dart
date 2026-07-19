import 'dart:io';

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
  const constNum = 0;
  print('Constant number: $constNum');

}

