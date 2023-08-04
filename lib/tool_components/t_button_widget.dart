import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class TButton extends TWidget {
  TButton(TWidgetProps twidget) : super(twidget);

  @override
  State<TButton> createState() => _TButtonState();
}

class _TButtonState extends TStatefulWidget<TButton> {
  Widget _computeButton(LayoutProps widgetProps) {
    String? buttonType = widgetProps.buttonType;
    String text = widgetProps.text ?? "";

    onClick() async {
      var rawOnClick = widgetProps.onClick;
      if (rawOnClick is String) {
        await widget.executeJSWithPagePath(rawOnClick, []);
      }
    }

    ButtonStyle? buttonStyle =
        ThemeDecoder.decodeButtonStyle(widgetProps.style);

    switch (buttonType) {
      case "icon":
        return IconButton(
          color: ThemeDecoder.decodeColor(widget.props?.color),
          icon: Icon(MdiIcons.fromString(widgetProps.icon ?? "")),
          style: buttonStyle,
          iconSize: widgetProps.iconSize,
          onPressed: onClick,
        );
      case "text":
        return TextButton(
          onPressed: onClick,
          style: buttonStyle,
          child: Text(
            text,
          ),
        );
      case "outlined":
        return OutlinedButton(
          onPressed: onClick,
          style: buttonStyle,
          child: Text(
            text,
          ),
        );
      case "filled":
        return FilledButton(
          onPressed: onClick,
          style: buttonStyle,
          child: Text(
            text,
          ),
        );
      default:
        return ElevatedButton(
          onPressed: onClick,
          style: buttonStyle,
          child: Text(
            text,
          ),
        );
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (widget.props != null) {
      snapshot = _computeButton(widget.props!);
    }

    return snapshot;
  }
}
