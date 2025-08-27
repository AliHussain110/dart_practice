// Advanced/Professional Stream Operations
// This file covers advanced stream concepts including broadcast streams, transformers, and stream combinations.
// Each function is designed to be implemented by the learner.

import 'dart:async';

// Part 1: Broadcast Stream
// #
// Implement a function that:
// 1. Creates a broadcast stream that emits numbers 1, 2, 3
// 2. Has two listeners that each collect the numbers
// 3. Returns the sum of all numbers collected by both listeners
Future<int> broadcastStreamSum() async {
  // TODO: Implement this function
  // Create a broadcast stream
  // Add two listeners
  // Each listener collects the numbers 1, 2, 3
  // Return the sum of all collected numbers (1+2+3 + 1+2+3 = 12)
  final controller = StreamController<int>.broadcast();
  
  // Add events to the stream
  controller.add(1);
  controller.add(2);
  controller.add(3);
  
  // Close the controller
  await controller.close();
  
  // Create two listeners
  final listener1 = controller.stream.toList();
  final listener2 = controller.stream.toList();
  
  // Wait for both listeners to complete
  final results = await Future.wait([listener1, listener2]);
  
  // Calculate the sum of all numbers
  int sum = 0;
  for (final list in results) {
    for (final number in list) {
      sum += number;
    }
  }
  
  return sum;
}

// Part 2: Stream Transformer
// #
// Implement a function that uses a custom StreamTransformer to:
// 1. Transform a stream of integers by filtering out odd numbers
// 2. Then double each remaining number
// 3. Return the transformed list
// Input: [1, 2, 3, 4, 5, 6]
// Expected output: [4, 8, 12]
Future<List<int>> transformStream() async {
  // TODO: Implement this function
  // Create a custom StreamTransformer that:
  // 1. Filters out odd numbers
  // 2. Doubles each remaining number
  // Apply it to a stream of [1, 2, 3, 4, 5, 6]
  // Return the transformed list
  final transformer = StreamTransformer<int, int>.fromHandlers(
    handleData: (data, sink) {
      if (data.isEven) {
        sink.add(data * 2);
      }
    },
  );
  
  final stream = Stream.fromIterable([1, 2, 3, 4, 5, 6]);
  final transformedStream = stream.transform(transformer);
  return await transformedStream.toList();
}

// Part 3: Stream Combination
// #
// Implement a function that:
// 1. Creates two streams:
//    - Stream A: Emits numbers 1, 2, 3
//    - Stream B: Emits letters "A", "B", "C"
// 2. Combines them into a single stream of tuples (number, letter)
// 3. Returns a list of these tuples: [(1, "A"), (2, "B"), (3, "C")]
Future<List<(int, String)>> combineStreams() async {
  // TODO: Implement this function
  // Create two streams: one with numbers [1, 2, 3] and one with letters ["A", "B", "C"]
  // Combine them into a single stream of tuples
  // Return the list of tuples
  final numberStream = Stream.fromIterable([1, 2, 3]);
  final letterStream = Stream.fromIterable(["A", "B", "C"]);
  
  // Use StreamZip to combine the streams
  final zippedStream = StreamZip([numberStream, letterStream]);
  
  // Transform each zipped event into a tuple
  final tupleStream = zippedStream.map((event) => (event[0] as int, event[1] as String));
  
  return await tupleStream.toList();
}

// Part 4: Stream Periodic
// #
// Implement a function that:
// 1. Creates a periodic stream that emits an incrementing counter every 100ms
// 2. Listens to the stream for 300ms and collects all emitted values
// 3. Returns the collected values as a list
// Expected output: [0, 1, 2]
Future<List<int>> periodicStream() async {
  // TODO: Implement this function
  // Create a periodic stream that emits an incrementing counter every 100ms
  // Listen for 300ms and collect all values
  // Return the collected values
  final stream = Stream.periodic(
    Duration(milliseconds: 100),
    (count) => count,
  );
  
  // Listen to the stream and collect values for 300ms
  final values = <int>[];
  final subscription = stream.listen(
    (value) => values.add(value),
  );
  
  // Cancel the subscription after 300ms
  await Future.delayed(Duration(milliseconds: 300));
  await subscription.cancel();
  
  return values;
}

// The following code is used to test and provide feedback on your solution.
// There is no need to read or modify it.

void main() async {
  print('Testing advanced stream operations...');
  List<String> messages = [];
  const passed = 'PASSED';
  const testFailedMessage = 'Test failed for the function:';
  const typoMessage = 'Test failed! Check for typos in your return value';
  
  try {
    messages
      ..add(_makeReadable(
          testLabel: 'Part 1',
          testResult: await _asyncEquals(
            expected: 12,
            actual: await broadcastStreamSum(),
            typoKeyword: '12',
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null': 'Test failed! Did you forget to implement or return from broadcastStreamSum?',
            '6': '$testFailedMessage broadcastStreamSum. Did you use a broadcast stream?',
            '0': '$testFailedMessage broadcastStreamSum. Did you process the stream correctly?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 2',
          testResult: await _asyncListEquals(
            expected: [4, 8, 12],
            actual: await transformStream(),
            typoKeyword: '12',
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null': 'Test failed! Did you forget to implement or return from transformStream?',
            '[]': '$testFailedMessage transformStream. Did you transform the stream correctly?',
            '[2, 4, 6]': '$testFailedMessage transformStream. Did you double the numbers?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 3',
          testResult: await _asyncTupleListEquals(
            expected: [(1, "A"), (2, "B"), (3, "C")],
            actual: await combineStreams(),
            typoKeyword: 'C',
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null': 'Test failed! Did you forget to implement or return from combineStreams?',
            '[]': '$testFailedMessage combineStreams. Did you combine the streams correctly?',
            '[(1, "A"), (2, "B")]': '$testFailedMessage combineStreams. Did you combine all elements?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 4',
          testResult: await _asyncListEquals(
            expected: [0, 1, 2],
            actual: await periodicStream(),
            typoKeyword: '2',
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null': 'Test failed! Did you forget to implement or return from periodicStream?',
            '[]': '$testFailedMessage periodicStream. Did you create a periodic stream?',
            '[0]': '$testFailedMessage periodicStream. Did you listen for the full duration?',
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

Future<String> _asyncTupleListEquals({
  required List<(int, String)> expected,
  required List<(int, String)> actual,
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
      if (element.$2.toString().contains(typoKeyword)) {
        return 'Test failed! Check for typos in your return value';
      }
    }
    
    return actual.toString();
  } catch (e) {
    return e.toString();
  }
}