import 'dart:convert';

import 'package:attendancemachine/models/event_hub.dart';
import 'package:attendancemachine/models/attendance_result.dart';
import 'package:attendancemachine/services/queue_service.dart';
import 'package:dart_amqp/dart_amqp.dart';
import '../utils/resources.dart' as resources;

class AttendanceResultQueueService extends QueueService {
  AttendanceResultQueueService(){}

  String deviceId = "";

  Future<void> listen(String deviceId, EventCallback<AttendanceResult> callback) async {
    await super.init();
    final exchange = await channel?.exchange(resources.ATTENDANCE_RESULT_EXCHANGE, ExchangeType.DIRECT);
    final consumer = await exchange?.bindPrivateQueueConsumer([deviceId]);
    consumer?.listen((message) {
      var body = message.payloadAsJson;
      var attendanceResult = AttendanceResult.fromJson(body);
      callback(attendanceResult);
    });

    onReady();
  }
}