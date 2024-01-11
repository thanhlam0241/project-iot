import 'package:attendancemachine/utils/logger.dart';
import 'package:dart_amqp/dart_amqp.dart';

class QueueService {
  QueueService() {
    print('QueueService created');
  }

  void dispose() {
    print('QueueService disposed');
  }
}

class WaitedQueueMessage {
  Object message;
  String? routingKey;
  WaitedQueueMessage(this.message, {this.routingKey});
}

class QueueExchanger {
  Client? client;
  Channel? channel;
  Exchange? exchange;

  bool _isReady = false;
  bool get isReady => _isReady;

  List<WaitedQueueMessage> _waitedQueueMessages = [];

  QueueExchangeService() {
  }

  Future<void> init(String queueName, ExchangeType exchangeType) async {
    // AMQP host URL
    String amqpUrl = "amqps://ubhptxwu:eh0iTQ0D22adEkSc9kyb2gB8hTZ_yVOt@armadillo.rmq.cloudamqp.com/ubhptxwu";

    // Parse the URL
    Uri uri = Uri.parse(amqpUrl);

    // Create ConnectionSettings
    ConnectionSettings settings = ConnectionSettings(
      host: uri.host,
      port: 5672,
      virtualHost: uri.path.substring(1),
      authProvider: PlainAuthenticator(uri.userInfo.split(":")[0], uri.userInfo.split(":")[1]),
      // You can set other properties like maxConnectionAttempts, reconnectWaitTime, etc.
    );
    client = Client(settings: settings);
    channel = await client?.channel();
    exchange = await channel?.exchange(queueName, exchangeType);
    _isReady = true;

    Logger.log('QueueExchangeService ready');

    String? defaultRoutingKey;

    if(exchangeType != ExchangeType.FANOUT && exchangeType != ExchangeType.HEADERS
    && _waitedQueueMessages.isNotEmpty) {
      defaultRoutingKey = exchange!.name;
    }
    if(_waitedQueueMessages.isNotEmpty) {
      for (var element in _waitedQueueMessages) {
        exchange?.publish(element.message, element.routingKey ?? defaultRoutingKey);
      }
      _waitedQueueMessages.clear();
    }
  }

  void publish(String message, {String? routingKey}) {
    if(!_isReady) {
      _waitedQueueMessages.add(WaitedQueueMessage(message, routingKey: routingKey));
      return;
    }
    if (exchange!.type != ExchangeType.FANOUT &&
        exchange!.type != ExchangeType.HEADERS &&
        (routingKey == null || routingKey.isEmpty)) {
      routingKey = exchange!.name;
    }
    exchange?.publish(message, routingKey);
  }

  void publishBinary(List<int> message, {String? routingKey}) {
    if(!_isReady) {
      _waitedQueueMessages.add(WaitedQueueMessage(message, routingKey: routingKey));
      return;
    }
    if (exchange!.type != ExchangeType.FANOUT &&
        exchange!.type != ExchangeType.HEADERS &&
        (routingKey == null || routingKey.isEmpty)) {
      routingKey = exchange!.name;
    }
    exchange?.publish(message, routingKey);
  }

  void dispose() {
    client?.close();
    print('QueueExchangeService disposed');
  }
}

// class QueueSubscriber {
//   QueueExchangeService(
//       {required this.queueName,
//       required this.exchangeName,
//       required this.routingKey}) {}
//
//   String host;
//   String queueName;
//
//   void dispose() {
//     print('QueueExchangeService disposed');
//   }
// }
