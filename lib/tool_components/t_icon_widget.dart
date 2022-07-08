import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_tool/page_utils/should_update.widget.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;

class T_Icon extends T_Widget {
  UtilsManager utils = getIt<UtilsManager>();

  T_Icon({
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
  State<T_Icon> createState() => _T_IconState();
}

class _T_IconState extends State<T_Icon> {
  LayoutProps? prevWidgetProps;
  LayoutProps? widgetProps;
  bool shouldWidgetUpdate() {
    widgetProps = widget.widgetProps;

    var shouldUpdate = !const DeepCollectionEquality().equals(
      prevWidgetProps,
      widgetProps,
    );

    return shouldUpdate;
  }

  @override
  Widget build(BuildContext context) {
    var path = widget.widgetProps.icon ?? "";
    return ShouldWidgetUpdate(
      key: widget.getBindingKey(),
      builder: (context) {
        prevWidgetProps = widget.widgetProps;
        return Icon(MdiIcons.fromString(path));
      },
      shouldWidgetUpdate: shouldWidgetUpdate(),
    );
  }
}
