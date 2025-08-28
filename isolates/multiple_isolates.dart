// Challenge 4: Multiple Isolates
// Create multiple isolates to process different parts of a task concurrently
import 'dart:async';
import 'dart:isolate';

// Helper function that runs in the isolate
void _computeSum(List<dynamic> args) {
  final numbers = args[0] as List<int>;
  final sendPort = args[1] as SendPort;
  final sum = numbers.fold(0, (prev, current) => prev + current);
  sendPort.send(sum);
}

Future<int> computeSumWithMultipleIsolates(List<int> numbers) async {
  // Split the list into 3 parts
  final partSize = (numbers.length / 3).ceil();
  final parts = <List<int>>[];
  
  for (int i = 0; i < 3; i++) {
    final start = i * partSize;
    final end = (i + 1) * partSize;
    if (start < numbers.length) {
      parts.add(numbers.sublist(start, end > numbers.length ? numbers.length : end));
    } else {
      parts.add([]);
    }
  }
  
  final futures = <Future<int>>[];
  
  for (final part in parts) {
    final receivePort = ReceivePort();
    Isolate.spawn(_computeSum, [part, receivePort.sendPort]);
    
    // Add the future to the list, casting the result of the Future.
    futures.add(receivePort.first.timeout(const Duration(seconds: 1)).then((value) => value as int));
  }
  
  // Wait for all isolates to complete
  final partialSums = await Future.wait(futures);
  
  // Sum the partial results to get the total sum
  final totalSum = partialSums.fold(0, (sum, partial) => sum + partial);
  
  return totalSum;
}
// Tests your solution (Don't edit!):
void main() async {
  final input = List.generate(15, (i) => i + 1); // [1, 2, 3, ..., 15]
  int result;
  
  try {
    result = await computeSumWithMultipleIsolates(input);
  } catch (e) {
    print('Caught an exception of type ${e.runtimeType} \n while running computeSumWithMultipleIsolates');
    return;
  }
  
  final errs = <String>[];
  final expected = 120; // Sum of numbers 1 to 15
  
  if (result != expected) {
    errs.add('The sum was $result \n rather than the expected ($expected).');
  }
  
  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}