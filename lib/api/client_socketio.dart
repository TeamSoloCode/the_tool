import 'package:socket_io_client/socket_io_client.dart' as socket_io_client;
import 'package:socket_io_client/src/manager.dart';

class SocketIOClient {
  static _SocketIOManager? _socketIOManager;

  static void init(String url, {Map? opts}) {
    _socketIOManager = _SocketIOManager(
      Manager(uri: url, options: opts),
      '/',
      opts,
    );
  }

  static void connect() {
    _socketIOManager?.connect();
  }

  static void disconnect() {
    _socketIOManager?.disconnect();
  }

  static void emit(String event, [dynamic data]) {
    _socketIOManager?.emit(event, data);
  }

  static void on(String event, dynamic Function(dynamic) callback) {
    _socketIOManager?.on(event, callback);
  }

  static void off(String event, [dynamic Function(dynamic)? callback]) {
    _socketIOManager?.off(event, callback);
  }
}

class _SocketIOManager extends socket_io_client.Socket {
  _SocketIOManager(Manager io, String nsp, Map? opts) : super(io, nsp, opts);
}
