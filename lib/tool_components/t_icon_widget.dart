import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/page_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

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
  Widget build(BuildContext context) {
    var path = widgetProps["icon"];
    return Icon(MdiIcons.fromString(path));
  }
}
