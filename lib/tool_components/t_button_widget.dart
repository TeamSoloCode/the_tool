import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:provider/provider.dart';

class T_Button extends T_Widget {
  T_Button({
    Key? key,
    required contextData,
    required widgetUuid,
    required widgetProps,
    required pagePath,
  }) : super(
          key: key,
          parentData: contextData,
          widgetUuid: widgetUuid,
          pagePath: pagePath,
          widgetProps: widgetProps,
        );

  @override
  State<T_Button> createState() => _T_ButtonState();
}

class _T_ButtonState extends State<T_Button> {
  Widget _snapshot = const SizedBox.shrink();
  LayoutProps? _props;

  Widget _computeButton(LayoutProps widgetProps) {
    String? buttonType = widgetProps.buttonType;
    String text = widgetProps.text ?? "";

    onClick() async {
      var rawOnClick = widgetProps.onClick;
      if (rawOnClick is String) {
        await widget.executeJSWithPagePath(rawOnClick);
      }
    }

    if (buttonType == "icon_button") {
      return IconButton(
        icon: Icon(MdiIcons.fromString(widgetProps.icon ?? "")),
        onPressed: onClick,
      );
    } else if (buttonType == "text_button") {
      return TextButton(
        child: Text(
          text,
        ),
        onPressed: onClick,
      );
    } else {
      return ElevatedButton(
        child: Text(
          text,
        ),
        onPressed: onClick,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? contextData = {};
    _props = context.select((ContextStateProvider value) {
      var data = Map<String, dynamic>.from(
        value.contextData[widget.pagePath] ?? {},
      );

      contextData = data;

      return widget.utils.computeWidgetProps(
        widget.widgetProps,
        data,
      );
    });

    if (_props?.hidden == true) {
      return const SizedBox.shrink();
    }

    _snapshot = _computeButton(_props!);

    return _snapshot;
  }
}
