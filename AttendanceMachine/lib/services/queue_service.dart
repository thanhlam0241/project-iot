import 'dart:io';

import 'package:attendancemachine/utils/logger.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:meta/meta.dart';
import '../utils/resources.dart' as resources;

abstract class QueueService {
  @protected
  Client? client;

  @protected
  Channel? channel;

  bool _isReady = false;
  bool get isReady => _isReady;

  static ConnectionSettings getSettingFromUrl(String amqpUrl) {
    SecurityContext context = SecurityContext.defaultContext;
    // Parse the URL
    Uri uri = Uri.parse(amqpUrl);

    // Create ConnectionSettings
    ConnectionSettings settings = ConnectionSettings(
      host: uri.host,
      port: 5671,
      virtualHost: uri.path.substring(1),
      authProvider: PlainAuthenticator(
          uri.userInfo.split(":")[0], uri.userInfo.split(":")[1]),
      tlsContext: context,
      // You can set other properties like maxConnectionAttempts, reconnectWaitTime, etc.
    );

    return settings;
  }

  ConnectionSettings getSetting(){
    String amqpUrl = resources.QUEUE_HOST;
    return getSettingFromUrl(amqpUrl);
  }

  Future<void> init() async {
    // AMQP host URL
    String amqpUrl = "";

    // Parse the URL
    Uri uri = Uri.parse(amqpUrl);

    // Create ConnectionSettings
    ConnectionSettings settings = getSetting();
    client = Client(settings: settings);
    channel = await client?.channel();

  }

  @protected
  void onReady() {
    _isReady = true;
  }

  Future<void> close() async {
    await channel?.close();
    await client?.close();
  }

  void dispose() {
    close();
  }
}


