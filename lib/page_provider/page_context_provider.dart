import 'package:flutter/foundation.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/utils.dart';

class PageContextProvider with ChangeNotifier {
  final Map<String, Map<String, dynamic>> _tWidgetsProps = {};
  final utils = getIt<UtilsManager>();

  Map<String, dynamic> get tWidgetsProps => _tWidgetsProps;

  void unregisterTWidgetsProps(String key) {
    _tWidgetsProps.remove(key);
  }

  void registerTWidgetsProps(
    String key,
    String pagePath,
    LayoutProps props,
    Map<String, dynamic> contextData,
  ) {
    var nextProps = utils.computeWidgetProps(props, contextData);
    var newValue = {
      "pagePath": pagePath,
      "rawProps": props,
      "props": nextProps,
    };

    _tWidgetsProps.update(
      key,
      (prevProps) {
        return newValue;
      },
      ifAbsent: () {
        return newValue;
      },
    );
  }

  void updateTWidgetProps(Map<String, dynamic> contextData) {
    _tWidgetsProps.forEach((key, value) {
      var nextProps = utils.computeWidgetProps(
        value["rawProps"] ?? const LayoutProps(),
        contextData[value["pagePath"]],
      );

      _tWidgetsProps.update(
        key,
        (prevProps) {
          return {...value, "props": nextProps};
        },
        ifAbsent: () {
          return {...value, "props": nextProps};
        },
      );
    });

    notifyListeners();
  }
}
