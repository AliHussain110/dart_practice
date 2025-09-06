import 'dart:isolate';
import 'dart:math';
import 'package:async/async.dart';

void _aggregateFunction(SendPort sendPort) async {
  Stream<int> loginStream = Stream.periodic(Duration(milliseconds: 300), (
    count,
  ) {
    return count;
  });
  Stream<int> transectionStream = Stream.periodic(Duration(milliseconds: 500), (
    count,
  ) {
    final random = Random();
    final randomNumber = 10 + random.nextInt((500 - 10) + 1);
    return randomNumber;
  });
  final combineStream = StreamZip([loginStream, transectionStream]);
  await for (final data in combineStream) {
    var map = {'total_logins': data[0], 'total_revenue': data[1]};
    sendPort.send(map);
  }
  ;
}

void runAnalytics() async {
  final receivePort = ReceivePort();
  await Isolate.spawn(_aggregateFunction, receivePort.sendPort);
  receivePort.listen((data) {
    print('stream data: $data');
  });
}
