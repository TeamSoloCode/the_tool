import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class T_Button extends TWidget {
  T_Button(TWidgetProps twidget) : super(twidget);

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
        color: ThemeDecoder.decodeColor(widget.props?.color),
        icon: Icon(MdiIcons.fromString(widgetProps.icon ?? "")),
        iconSize: widgetProps.iconSize,
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
