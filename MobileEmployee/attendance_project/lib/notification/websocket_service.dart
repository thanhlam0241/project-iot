import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'notification_attendance.dart';

typedef WebSocketOnMessageCallback = void Function(String message);

class WebSocketService{
  static final WebSocketService instance = WebSocketService();
  WebSocketService(){
    _loadDate();
  }
  List<WebSocketOnMessageCallback> _onMessageCallbacks = [];
  StompClient? gol_client;
  String? id;

  Future<void> _loadDate() async{
    await getApplicationDocumentsDirectory()
        .then((value) => File("${value.path}/token.xxx"))
        .then((value) => value.readAsString())
        .then((value) => {
      id = value
    });
  }

  void onConnectCallback(StompFrame connectFrame) {
    // client is connected and ready
    print("id dong 32");
    print(id);
    gol_client?.subscribe(destination: '/topic/message/${id!}', headers: {}, callback: (frame) {
      final msg = frame.body;
      // Received a frame for this subscription
      if(msg != null && msg.isNotEmpty && _onMessageCallbacks.isNotEmpty){
        // final msg = utf8.decode(msg);
        for (var element in _onMessageCallbacks) {
          element(msg);
        }
      }

      //_showNotification(frame.body.toString());
    });

    print("Socket Connected");
  }
  void addOnMessageCallback(WebSocketOnMessageCallback callback){
    _onMessageCallbacks.add(callback);
  }
  void removeOnMessageCallback(WebSocketOnMessageCallback callback){
    _onMessageCallbacks.remove(callback);
  }
  void init(String userId){
    gol_client?.deactivate();

    gol_client = StompClient(
        config: StompConfig.sockJS(
          url: 'https://server-iot-tggk.onrender.com/ws',
          onConnect: onConnectCallback,
          onWebSocketError: (dynamic error) => print(error.toString()),
          onUnhandledFrame: (StompFrame frame) => print(frame.body),
          onUnhandledMessage: (StompFrame frame) => print(frame.body),
          onUnhandledReceipt: (StompFrame frame) => print(frame.body),

        )
    );
    id = userId;
    print("Socket Created");
    print(gol_client != null);
    gol_client?.activate();
  }

  void logout(){
    gol_client?.deactivate();
  }
}