library t_appbar;

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

PreferredSizeWidget? computeAppBar(
  String pageId,
  LayoutProps? appBarConfig,
) {
  if (appBarConfig == null) {
    return null;
  }

  if (appBarConfig.title != null) {
    Widget? title = UtilsManager.computeTWidgets(
      appBarConfig.title,
      pagePath: pageId,
      childData: const {},
    );

    return AppBar(
      title: title,
      centerTitle: false,
      leading: UtilsManager.computeTWidgets(
        appBarConfig.leading,
        pagePath: pageId,
        childData: const {},
      ),
      actions: UtilsManager.computeListTWidgets(
        appBarConfig.actions,
        pagePath: pageId,
        childData: const {},
      ),
    );
  }

  var customContent = appBarConfig.content;
  return PreferredSize(
    preferredSize: Size.fromHeight(customContent?.height ?? 120),
    child: TWidgets(
      layout: customContent!,
      pagePath: pageId,
      childData: const {},
    ),
  );
}
