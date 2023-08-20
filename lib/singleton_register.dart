import 'package:the_tool/api/client_api.dart';
import 'package:the_tool/api/client_socketio.dart';
import 'package:the_tool/config/config.dart';
import 'package:the_tool/js_utils/base_invoke_is.dart';
import 'package:the_tool/page_provider/auth_manager_provider.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_provider/resize_provider.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
import 'package:the_tool/page_utils/permission_manager.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/utils.dart';

class SingletonRegister {
  static Future<void> register() async {
    getIt.registerSingleton<EnvironmentConfig>(
      EnvironmentConfig(),
      signalsReady: true,
    );

    getIt.registerSingleton<UtilsManager>(UtilsManager(), signalsReady: true);

    getIt.registerSingleton<StorageManager>(StorageManager(),
        signalsReady: true);

    await getIt<StorageManager>().initStorageBox();

    getIt.registerSingleton<APIClientManager>(
      APIClientManager(),
      signalsReady: true,
    );

    getIt.registerSingleton<ContextStateProvider>(
      ContextStateProvider(),
      signalsReady: true,
    );

    getIt.registerSingleton<ResizeProvider>(
      ResizeProvider(),
      signalsReady: true,
    );

    getIt.registerSingleton<PermissionManager>(
      PermissionManager(),
      signalsReady: true,
    );

    getIt.registerSingleton<ThemeProvider>(
      ThemeProvider(),
      signalsReady: true,
    );

    getIt.registerSingleton<AuthContextProvider>(
      AuthContextProvider(),
      signalsReady: true,
    );

    getIt.registerSingleton<BaseInvokeJS>(
      const BaseInvokeJS(),
      signalsReady: true,
    );
  }

  static registerSocketIOClient(String url, {Map? opts}) {
    SocketIOClient.init(url, opts: opts);

    getIt.registerSingleton<SocketIOClient>(
      SocketIOClient(),
      signalsReady: true,
    );
  }
}
