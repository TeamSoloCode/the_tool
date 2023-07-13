import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_tool/api_client.dart';
import 'dart:io' if (dart.library.html) "dart:html";
import 'package:the_tool/js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/js_utils/web_eval_utils/web_eval_js.dart';
import 'package:the_tool/page_provider/auth_manager_provider.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/static_pages/server_not_found.page.dart'
    deferred as server_not_found;
import 'package:the_tool/tool_components/page_container_widget.dart'
    deferred as page_container;
import 'package:the_tool/static_pages/select_project.page.dart'
    deferred as select_project;
import 'package:provider/provider.dart';

class TheTool extends StatefulWidget {
  const TheTool({Key? key}) : super(key: key);

  @override
  State<TheTool> createState() => _TheToolState();
}

class _TheToolState extends State<TheTool> {
  String? _selectedProjectName;
  String? _cannotLoadConfig;

  void _loadWebCoreJSCode(BuildContext context) {
    UtilsManager utils = getIt<UtilsManager>();

    utils.evalJS = EvalJS(
      context: context,
    );
  }

  void _loadProject(String projectName) {
    setState(() {
      _selectedProjectName = projectName;
    });
  }

  Future<bool> _isReadyToRun() async {
    final apiClient = getIt<APIClientManager>();
    final storage = getIt<StorageManager>();
    final cacheProjectName = storage.getLocalBox("projectName");
    apiClient.projectName = _selectedProjectName ?? cacheProjectName;
    ClientConfig? config;
    try {
      config = await apiClient.getClientConfig();
    } catch (error) {
      await server_not_found.loadLibrary();
      setState(() {
        _cannotLoadConfig = error.toString();
      });
    }
    getIt<ContextStateProvider>().appConfig = config;

    await page_container.loadLibrary();

    if (kIsWeb) _loadWebCoreJSCode(context);
    return true;
  }

  Future<bool> _loadSelectProjectPage() async {
    final storage = getIt<StorageManager>();
    final cacheProjectName = storage.getLocalBox("projectName");
    if (storage.getLocalBox("remember") == true && cacheProjectName != null) {
      _selectedProjectName = cacheProjectName;
      await _isReadyToRun();
      return true;
    }

    await select_project.loadLibrary();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    context.select((AuthContextProvider value) {
      return value;
    });

    if (_cannotLoadConfig != null) {
      return server_not_found.ServerNotFound();
    }

    return FutureBuilder<bool>(
      key: ValueKey(_selectedProjectName),
      future: _selectedProjectName == null
          ? _loadSelectProjectPage()
          : _isReadyToRun(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Offstage();
        }
        if (_selectedProjectName == null) {
          return select_project.SelectProjectPage(
            loadProject: _loadProject,
          );
        } else {
          return ScreenUtilInit(
            builder: (context, child) {
              return child!;
            },
            child: page_container.PageContainer(),
          );
        }
      },
    );
  }
}
