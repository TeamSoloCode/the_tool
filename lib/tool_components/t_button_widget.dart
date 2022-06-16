import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

class T_Button extends T_Widget {
  final UtilsManager utils = getIt<UtilsManager>();

  T_Button({
    Key? key,
    required executeJS,
    required widgetProps,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
          contextData: contextData,
        );

  @override
  State<T_Button> createState() => _T_ButtonState();
}

class _T_ButtonState extends State<T_Button> {
  Widget _computeButton() {
    var widgetProps = widget.widgetProps;

    String? buttonType = widgetProps["buttonType"];
    String text = widget.utils.bindingValueToText(
      widget.contextData,
      widgetProps["text"],
    );

    onClick() async {
      var rawOnClick = widgetProps["onClick"];
      if (rawOnClick is String) {
        await widget.executeJS(rawOnClick);
      }
    }

    if (buttonType == "icon_button") {
      return IconButton(
        icon: Icon(MdiIcons.fromString(widgetProps["icon"])),
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
    return _computeButton();
  }
}
