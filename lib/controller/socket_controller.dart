import 'package:flutter_app_test1/helpers/local_storage_service.dart';
import 'package:flutter_app_test1/helpers/network_api.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../service/tokens/token_interceptor.dart';

enum SocketSatus { connecting, connected, error, disconnect }

class SocketController extends GetxController {
  Rx<SocketSatus> socketStatus = SocketSatus.disconnect.obs;
  socket_io.Socket? socket;
  String? _currentToken;

  /// เชื่อมต่อ Socket (เหมือน getSocket ใน TypeScript)
  /// ถ้า socket connected อยู่แล้วและ token ไม่เปลี่ยน จะ return socket เดิม
  /// ถ้า token เปลี่ยน จะ disconnect และสร้างใหม่
  Future<socket_io.Socket> connectSocket() async {
    // ดึง token ปัจจุบัน
    final accessToken = await LocalStorageService.getToken(Token.accessToken);

    // เช็คว่า socket มีอยู่แล้ว, connected, และ token ไม่เปลี่ยน
    if (socket != null && socket!.connected && _currentToken == accessToken) {
      print('✅ [Socket] Reusing existing socket connection');
      return socket!;
    }

    // ถ้า token เปลี่ยน หรือ socket ยังไม่ connected
    if (socket != null) {
      print('🔄 [Socket] Token changed or socket disconnected, recreating...');
      socket!.disconnect();
      socket!.dispose();
      socket = null;
    }

    // สร้าง socket ใหม่
    socket = await _createSocket(accessToken);
    _currentToken = accessToken;

    // ตั้งค่า listeners
    _setupSocketListeners();

    // Connect socket (เพราะใช้ autoConnect: false)
    socket!.connect();

    return socket!;
  }

  /// สร้าง Socket instance ใหม่
  Future<socket_io.Socket> _createSocket(String? accessToken) async {
    final optionBuilder = socket_io.OptionBuilder()
        .setTransports([
          'websocket',
          'polling',
        ]) // Try websocket first, fallback to polling
        .disableAutoConnect() // ไม่ connect อัตโนมัติ (เหมือน autoConnect: false)
        .enableReconnection() // เปิด reconnection
        .setReconnectionDelay(1000) // Delay 1 วินาทีก่อน reconnect
        .setReconnectionAttempts(5); // ลอง reconnect 5 ครั้ง

    // เพิ่ม auth token และ headers ถ้ามี
    if (accessToken != null && accessToken.isNotEmpty) {
      optionBuilder.setExtraHeaders({'Authorization': 'Bearer $accessToken'});
      // Note: socket_io_client Flutter อาจไม่รองรับ auth object โดยตรง
      // แต่สามารถส่งผ่าน extraHeaders ได้
    }

    print('🔌 [Socket] Creating socket connection to: ${NetworkAPI.socketUrl}');

    return socket_io.io(NetworkAPI.socketUrl, optionBuilder.build());
  }

  /// ตั้งค่า event listeners สำหรับ socket
  void _setupSocketListeners() {
    // Connection successful
    socket!.onConnect((_) {
      socketStatus.value = SocketSatus.connected;
      print('✅ [Socket] Connected, ID: ${socket?.id}');
    });

    // Connection error (ตั้งก่อน connect)
    socket!.on('connect_error', (data) async {
      socketStatus.value = SocketSatus.error;
      final memberId = (await LocalStorageService().getUserInfo())['userId'];
      if (memberId != null) {
        print('❌ [Socket] Connection error - memberId: $memberId');
        print('❌ [Socket] Error data: $data');
      } else {
        print('❌ [Socket] Connection error: $data');
      }
    });

    socket!.on('connection:success', (data) {
      print('✅ [Socket] Connection success');
      print('✅ [Socket] connection data: $data');
    });

    // Disconnected
    socket!.onDisconnect((_) {
      socketStatus.value = SocketSatus.disconnect;
      print('🔌 [Socket] Disconnected');
    });

    // General error
    socket!.onError((error) {
      socketStatus.value = SocketSatus.error;
      print('❌ [Socket] Error: $error');
    });

    // Reconnection events
    socket!.onReconnect((attempt) {
      print('🔄 [Socket] Reconnecting... Attempt: $attempt');
      socketStatus.value = SocketSatus.connecting;
    });

    socket!.onReconnectAttempt((attempt) {
      print('🔄 [Socket] Reconnection attempt: $attempt');
    });

    socket!.onReconnectError((error) {
      print('❌ [Socket] Reconnection error: $error');
    });

    socket!.onReconnectFailed((_) {
      print('❌ [Socket] Reconnection failed');
      socketStatus.value = SocketSatus.error;
    });
  }

  @override
  void onClose() {
    socket?.dispose();
    super.onClose();
  }
}
