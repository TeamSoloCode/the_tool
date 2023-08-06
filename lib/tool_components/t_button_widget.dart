import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class TButton extends TStatelessWidget {
  TButton(TWidgetProps twidget) : super(twidget);

  Function() onClick(LayoutProps props) {
    return () {
      var rawOnClick = props.onClick;
      if (rawOnClick is String) {
        executeJSWithPagePath(rawOnClick, []);
      }
    };
  }

  Widget _computeButton(LayoutProps widgetProps) {
    String? buttonType = widgetProps.buttonType;
    String text = widgetProps.text ?? "";

    ButtonStyle? buttonStyle = ThemeDecoder.decodeButtonStyle(
      widgetProps.style,
    );
    final buttonOnClick = onClick(widgetProps);

    switch (buttonType) {
      case "icon":
        return IconButton(
          color: ThemeDecoder.decodeColor(widgetProps.color),
          icon: Icon(MdiIcons.fromString(widgetProps.icon ?? "")),
          style: buttonStyle,
          iconSize: widgetProps.iconSize,
          onPressed: buttonOnClick,
        );
      case "text":
        return TextButton(
          onPressed: buttonOnClick,
          style: buttonStyle,
          child: Text(
            text,
          ),
        );
      case "outlined":
        return OutlinedButton(
          onPressed: buttonOnClick,
          style: buttonStyle,
          child: Text(
            text,
          ),
        );
      case "filled":
        return FilledButton(
          onPressed: buttonOnClick,
          style: buttonStyle,
          child: Text(
            text,
          ),
        );
      default:
        return ElevatedButton(
          onPressed: buttonOnClick,
          style: buttonStyle,
          child: Text(
            text,
          ),
        );
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (props != null) {
      snapshot = _computeButton(props!);
    }

    return snapshot;
  }
}
