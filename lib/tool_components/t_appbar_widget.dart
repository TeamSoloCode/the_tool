library t_appbar;

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

PreferredSizeWidget? computeAppBar(
  String pageId,
  LayoutProps? appBarConfig,
) {
  if (appBarConfig == null) {
    return null;
  }

  if (appBarConfig.title != null) {
    Widget title = TWidgets(
      layout: appBarConfig.title!,
      pagePath: pageId,
      childData: const {},
    );

    // List<Widget> actions = (appBarConfig["actions"] as List<dynamic>).map(
    //   (e) {
    //     return SizedBox();
    //   },
    // ).toList();

    return AppBar(
      title: title,
      centerTitle: false,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.light_mode),
        ),
      ],
    );
  }

  // var customContent = appBarConfig.title;
  // return PreferredSize(
  //   preferredSize: Size.fromHeight(customContent?.height ?? 120),
  //   child: TWidgets(
  //     layout: customContent!,
  //     pagePath: pageId,
  //     childData: const {},
  //   ),
  // );
}
