

import 'package:flutter_app_test1/helpers/network_api.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io ;

enum SocketSatus {
  connecting, 
  connected,
  error,
  disconnect
}
class SocketController extends GetxController {
  Rx<SocketSatus> socketStatus = SocketSatus.connecting.obs;
 socket_io.Socket? socket;
  
    void connectSocket() {
      socket = socket_io.io(
      NetworkAPI.socketUrl,    
      socket_io.OptionBuilder()
       .setTransports(['websocket']).build());
      
      socket!.onConnect((_){
        socketStatus = SocketSatus.connected.obs;
        print('Socket Connected');
      });

      socket!.onDisconnect((_) {
        socketStatus = SocketSatus.disconnect.obs;
        print('Socket Disconnected');
      });
      
      socket!.onError((_) {
        socketStatus = SocketSatus.error.obs;
        print('Socket Error');
      });
    }

  @override
  void onClose() {
    socket?.dispose();
    super.onClose();
  }
}