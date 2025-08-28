// Challenge 1: Basic Isolate Communication
// Create an isolate that computes the sum of a list of numbers and returns the result

import 'dart:isolate';

// TODO: Implement this function
// 1. Create an isolate that receives a list of integers
// 2. Compute the sum of the integers in the isolate
// 3. Send the sum back to the main isolate
// 4. Return the sum from the function
Future<int> computeSumInIsolate(List<int> numbers) async {
  // TODO: Implement this function using isolates
  final sumOfList = await Isolate.run((){
    final sum = numbers.fold(0,(p,e)=> p+e);
    return sum;
  });
  return sumOfList;
}

// Tests your solution (Don't edit!):
void main() async {
  final input = [1, 2, 3, 4, 5];
  int result;
  
  try {
    result = await computeSumInIsolate(input);
  } catch (e) {
    print('Caught an exception of type ${e.runtimeType} \n while running computeSumInIsolate');
    return;
  }
  
  final errs = <String>[];
  final expected = 15; // 1+2+3+4+5 = 15
  
  if (result != expected) {
    errs.add('The sum was $result \n rather than the expected ($expected).');
  }
  
  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}