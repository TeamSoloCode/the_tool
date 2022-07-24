import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:provider/provider.dart';

class T_Text extends T_StatelessWidget {
  T_Text({
    Key? key,
    required widgetProps,
    required contextData,
    required pagePath,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
        );
  var text = "";
  Widget _snapshot = const SizedBox.shrink();
  LayoutProps? _props;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? contextData = {};
    _props = context.select((ContextStateProvider value) {
      var data = Map<String, dynamic>.from(
        value.contextData[pagePath] ?? {},
      );

      contextData = data;

      return utils.computeWidgetProps(
        widgetProps,
        data,
      );
    });

    debugPrint("T_Text");

    if (_props?.hidden == true) {
      return const SizedBox.shrink();
    }

    if (kIsWeb) {
      _snapshot = SelectableText(
        _props?.text ?? "",
        style: ThemeDecoder.decodeTextStyle(_props?.toJson()),
      );
    } else {
      _snapshot = Text(
        _props?.text ?? "",
        style: ThemeDecoder.decodeTextStyle(_props?.toJson()),
      );
    }

    return _snapshot;
  }
}
