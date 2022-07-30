import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';

class T_Button extends TWidget {
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

class _T_ButtonState extends TStatefulWidget<T_Button> {
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
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = _computeButton(_props);
    }

    return _snapshot;
  }
}
