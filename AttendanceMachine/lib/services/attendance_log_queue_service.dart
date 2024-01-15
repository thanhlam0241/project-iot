import 'dart:io';

import 'package:attendancemachine/services/queue_service.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/foundation.dart';

import '../utils/resources.dart' as resources;

class AttendanceLogQueueService extends QueueService{
  Queue? queue;
  AttendanceLogQueueService(){}

  Uint8List _devideId = Uint8List(0);

  Uint8List hexToUint8List(String hex) {
    if (hex.length % 2 != 0) {
      throw 'Odd number of hex digits';
    }
    var l = hex.length ~/ 2;
    var result = Uint8List(l);
    for (var i = 0; i < l; ++i) {
      var x = int.parse(hex.substring(2 * i, 2 * (i + 1)), radix: 16);
      if (x.isNaN) {
        throw 'Expected hex string';
      }
      result[i] = x;
    }
    return result;
  }

  Future<void> setup(String deviceId) async {
    await super.init();
    queue = await channel?.queue(resources.ATTENDANCE_LOG_QUEUE);
    _devideId = hexToUint8List(deviceId);
    onReady();
  }

  void publish(List<Uint8List> image) {
      assert(isReady == true, "Queue is not ready, please call setup() first");
      var b = BytesBuilder();
      b.add(_devideId);
      // n < 256
      final n = image.length;
      b.add(Uint8List.fromList([n]));
      var indexes = Uint8List(n * 4);
      var index = n * 4 + b.length;

      // List<int> fileIndexes = [index];
      // List<int> realFileIndexes = [];

      for (var i = 0; i < n; i++) {
        indexes[i * 4] = index & 0xFF;
        indexes[i * 4 + 1] = (index >> 8) & 0xFF;
        indexes[i * 4 + 2] = (index >> 16) & 0xFF;
        indexes[i * 4 + 3] = (index >> 24) & 0xFF;

        index += image[i].length;
        // fileIndexes.add(index);
      }
      b.add(indexes);
      for (var i = 0; i < n; i++) {
        // realFileIndexes.add(b.length);
        b.add(image[i]);
      }
      var msg = b.toBytes();
      queue?.publish(msg);
      // print(fileIndexes);
      // print(realFileIndexes);
  }

  // void publish(Uint8List video) {
  //   if (isReady == false) {
  //     throw Exception("Queue is not ready, please call setup() first");
  //   }
  //   var b = BytesBuilder();
  //   b.add(_devideId);
  //   b.add(video);
  //   var msg = b.toBytes();
  //   queue?.publish(msg);
  // }

}