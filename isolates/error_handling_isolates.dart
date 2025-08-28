// Challenge 2: Error Handling in Isolates
// Create an isolate that processes data and handles potential errors

import 'dart:isolate';

// TODO: Implement this function
// 1. Create an isolate that receives a string
// 2. Parse the string as an integer
// 3. If parsing fails, catch the error and send back -1
// 4. If successful, send back the integer value multiplied by 2
// 5. Return the result from the function
Future<int> processStringInIsolate(String input) async {
  // TODO: Implement this function with proper error handling
  final value = await Isolate.run((){
    try{
      int number = int.parse(input);
      return number * 2;
    }catch(e){
      return -1;
    }
  });
  return value;
}

// Tests your solution (Don't edit!):
void main() async {
  final errs = <String>[];
  
  // Test case 1: Valid input
  try {
    final result1 = await processStringInIsolate('10');
    if (result1 != 20) {
      errs.add('Test case 1 failed: got $result1 instead of 20');
    }
  } catch (e) {
    errs.add('Test case 1 threw exception: ${e.runtimeType}');
  }
  
  // Test case 2: Invalid input
  try {
    final result2 = await processStringInIsolate('not a number');
    if (result2 != -1) {
      errs.add('Test case 2 failed: got $result2 instead of -1');
    }
  } catch (e) {
    errs.add('Test case 2 threw exception: ${e.runtimeType}');
  }
  
  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}