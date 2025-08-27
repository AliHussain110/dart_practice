// Basic Stream Operations
// This file covers fundamental stream concepts including creation, listening, and basic transformations.
// Each function is designed to be implemented by the learner.

import 'dart:async';

// Part 1: Stream Creation and Listening
// #
// Implement a function that creates a stream of integers and returns their sum.
// The stream should emit numbers 1 through 5 sequentially.
Future<int> sumStream() async {
  // TODO: Implement this function
  // Create a stream that emits numbers 1, 2, 3, 4, 5
  // Calculate and return the sum of these numbers
  final stream = Stream.fromIterable([1, 2, 3, 4, 5]);
  int sum = 0;
  await for (final value in stream) {
    sum += value;
  }
  return sum;
}

// Part 2: Stream Transformation
// #
// Implement a function that transforms a stream of integers into a stream of their squares.
// The input stream emits numbers 1, 2, 3.
// Return a list containing the squares [1, 4, 9].
Future<List<int>> squareStream() async {
  // TODO: Implement this function
  // Create a stream that emits 1, 2, 3
  // Transform each value to its square
  // Collect and return the results as a list
  final stream = Stream.fromIterable([1, 2, 3]);
  final squaredStream = stream.map((number) => number * number);
  return await squaredStream.toList();
}

// Part 3: Stream Filtering
// #
// Implement a function that filters a stream of integers to only include even numbers.
// The input stream emits numbers 1, 2, 3, 4, 5, 6.
// Return a list containing only the even numbers [2, 4, 6].
Future<List<int>> filterEvenNumbers() async {
  // TODO: Implement this function
  // Create a stream that emits 1, 2, 3, 4, 5, 6
  // Filter to only include even numbers
  // Collect and return the results as a list
  final stream = Stream.fromIterable([1, 2, 3, 4, 5, 6]);
  final evenStream = stream.where((number) => number.isEven);
  return await evenStream.toList();
}

// The following code is used to test and provide feedback on your solution.
// There is no need to read or modify it.

void main() async {
  print('Testing basic stream operations...');
  List<String> messages = [];
  const passed = 'PASSED';
  const testFailedMessage = 'Test failed for the function:';
  const typoMessage = 'Test failed! Check for typos in your return value';
  
  try {
    messages
      ..add(_makeReadable(
          testLabel: 'Part 1',
          testResult: await _asyncEquals(
            expected: 15,
            actual: await sumStream(),
            typoKeyword: '15',
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null': 'Test failed! Did you forget to implement or return from sumStream?',
            '0': '$testFailedMessage sumStream. Did you process the stream correctly?',
            '5': '$testFailedMessage sumStream. Did you sum all the numbers?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 2',
          testResult: await _asyncListEquals(
            expected: [1, 4, 9],
            actual: await squareStream(),
            typoKeyword: '9',
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null': 'Test failed! Did you forget to implement or return from squareStream?',
            '[]': '$testFailedMessage squareStream. Did you transform the stream correctly?',
            '[1, 2, 3]': '$testFailedMessage squareStream. Did you square the numbers?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 3',
          testResult: await _asyncListEquals(
            expected: [2, 4, 6],
            actual: await filterEvenNumbers(),
            typoKeyword: '6',
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null': 'Test failed! Did you forget to implement or return from filterEvenNumbers?',
            '[]': '$testFailedMessage filterEvenNumbers. Did you filter the stream correctly?',
            '[1, 3, 5]': '$testFailedMessage filterEvenNumbers. Did you filter for even numbers?',
          }))
      ..removeWhere((m) => m.contains(passed))
      ..toList();

    if (messages.isEmpty) {
      print('Success. All tests passed!');
    } else {
      messages.forEach(print);
    }
  } on UnimplementedError {
    print('Test failed! Did you forget to implement one of the functions?');
  } catch (e) {
    print('Tried to run solution, but received an exception: $e');
  }
}

// Test helpers.
String _makeReadable({
  required String testResult,
  required Map<String, String> readableErrors,
  required String testLabel,
}) {
  if (readableErrors.containsKey(testResult)) {
    var readable = readableErrors[testResult];
    return '$testLabel $readable';
  } else {
    return '$testLabel $testResult';
  }
}

// Assertions used in tests.
Future<String> _asyncEquals({
  required dynamic expected,
  required dynamic actual,
  required String typoKeyword,
}) async {
  try {
    if (expected == actual) {
      return 'PASSED';
    } else if (actual.toString().contains(typoKeyword)) {
      return 'Test failed! Check for typos in your return value';
    } else {
      return actual.toString();
    }
  } catch (e) {
    return e.toString();
  }
}

Future<String> _asyncListEquals({
  required List<dynamic> expected,
  required List<dynamic> actual,
  required String typoKeyword,
}) async {
  try {
    if (expected.length == actual.length) {
      bool allMatch = true;
      for (int i = 0; i < expected.length; i++) {
        if (expected[i] != actual[i]) {
          allMatch = false;
          break;
        }
      }
      if (allMatch) return 'PASSED';
    }
    
    // Check for typo in any element
    for (final element in actual) {
      if (element.toString().contains(typoKeyword)) {
        return 'Test failed! Check for typos in your return value';
      }
    }
    
    return actual.toString();
  } catch (e) {
    return e.toString();
  }
}