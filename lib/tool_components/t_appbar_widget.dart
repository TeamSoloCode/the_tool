library t_appbar;

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/app_bar_props/app_bar_props.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:gato/gato.dart' as gato;

PreferredSizeWidget? computeAppBar(
  String pageId,
  AppBarProps? appBarConfig,
) {
  if (appBarConfig == null) {
    return null;
  }

  if (appBarConfig.content != null) {
    Widget title = TWidgets(
      layout: appBarConfig.content!,
      pagePath: pageId,
    );

    // List<Widget> actions = (appBarConfig["actions"] as List<dynamic>).map(
    //   (e) {
    //     return SizedBox();
    //   },
    // ).toList();

    return AppBar(
      title: title,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.light_mode),
        ),
      ],
    );
  }

  var customContent = gato.get(appBarConfig, "custom");
  return PreferredSize(
    preferredSize: Size.fromHeight(gato.get(customContent, "height") ?? 120),
    child: TWidgets(
      layout: customContent,
      pagePath: pageId,
    ),
  );
}
