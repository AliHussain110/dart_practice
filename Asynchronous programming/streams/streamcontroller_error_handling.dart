// Intermediate Stream Operations
// This file covers intermediate stream concepts including controllers, error handling, and subscriptions.
// Each function is designed to be implemented by the learner.
import 'dart:async';

// Part 1: Stream Controller
// #
// Implement a function that uses a StreamController to:
// 1. Add three events to the stream: "Event 1", "Event 2", "Event 3"
// 2. Close the controller
// 3. Return all collected events as a list
Future<List<String>> useStreamController() async {
  // TODO: Implement this function
  // Create a StreamController
  // Add three events to the sink
  // Close the controller
  // Collect and return all events
  final controller = StreamController<String>();
  
  // Add events to the stream
  controller.add('Event 1');
  controller.add('Event 2');
  controller.add('Event 3');
  
  // Close the controller
  await controller.close();
  
  // Collect all events
  return await controller.stream.toList();
}

// Part 2: Stream Error Handling
// #
// Implement a function that processes a stream that may emit errors.
// The stream emits "Success" followed by an error.
// Catch the error and return "Error caught".
Future<String> handleStreamError() async {
  // TODO: Implement this function
  // Create a stream that emits "Success" then throws an exception
  // Catch the error and return "Error caught"
  final controller = StreamController<String>();
  
  // Add success event
  controller.add('Success');
  
  // Add error event
  controller.addError(Exception('Stream error'));
  
  // Close the controller
  await controller.close();
  
  // Transform the stream to handle errors
  final transformedStream = controller.stream.transform(
    StreamTransformer<String, String>.fromHandlers(
      handleData: (data, sink) {
        sink.add(data);
      },
      handleError: (error, stackTrace, sink) {
        sink.add('Error caught');
      },
    ),
  );
  
  // Collect the last value (which will be "Error caught")
  String result = '';
  await for (final value in transformedStream) {
    result = value;
  }
  return result;
}

// Part 3: Stream Subscription
// #
// Implement a function that:
// 1. Creates a stream that emits numbers 1, 2, 3, 4, 5
// 2. Listens to the stream and cancels the subscription after receiving 3 numbers
// 3. Returns the sum of the numbers received before cancellation
Future<int> cancelAfterThree() async {
  // TODO: Implement this function
  // Create a stream that emits 1, 2, 3, 4, 5
  // Listen to the stream and cancel after 3 numbers
  // Return the sum of the numbers received (1+2+3 = 6)
  final stream = Stream.fromIterable([1, 2, 3, 4, 5]);
  int sum = 0;
  int count = 0;
  
  final completer = Completer<void>();
  late StreamSubscription subscription;
  
  subscription = stream.listen(
    (number) {
      sum += number;
      count++;
      if (count >= 3) {
        subscription.cancel();
        completer.complete();
      }
    },
  );
  
  // Wait for the completer to complete (after cancellation)
  await completer.future;
  return sum;
}

// The following code is used to test and provide feedback on your solution.
// There is no need to read or modify it.

void main() async {
  print('Testing intermediate stream operations...');
  List<String> messages = [];
  const passed = 'PASSED';
  const testFailedMessage = 'Test failed for the function:';
  const typoMessage = 'Test failed! Check for typos in your return value';
  
  try {
    messages
      ..add(_makeReadable(
          testLabel: 'Part 1',
          testResult: await _asyncListEquals(
            expected: ['Event 1', 'Event 2', 'Event 3'],
            actual: await useStreamController(),
            typoKeyword: 'Event 3',
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null': 'Test failed! Did you forget to implement or return from useStreamController?',
            '[]': '$testFailedMessage useStreamController. Did you add events to the stream?',
            '["Event 1"]': '$testFailedMessage useStreamController. Did you add all events?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 2',
          testResult: await _asyncEquals(
            expected: 'Error caught',
            actual: await handleStreamError(),
            typoKeyword: 'Error caught',
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null': 'Test failed! Did you forget to implement or return from handleStreamError?',
            'Success': '$testFailedMessage handleStreamError. Did you handle the error correctly?',
            'Exception: Stream error': '$testFailedMessage handleStreamError. Did you catch the error?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 3',
          testResult: await _asyncEquals(
            expected: 6,
            actual: await cancelAfterThree(),
            typoKeyword: '6',
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null': 'Test failed! Did you forget to implement or return from cancelAfterThree?',
            '15': '$testFailedMessage cancelAfterThree. Did you cancel the subscription after 3 numbers?',
            '0': '$testFailedMessage cancelAfterThree. Did you process the stream correctly?',
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