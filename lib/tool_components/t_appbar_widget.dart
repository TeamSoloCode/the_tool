library t_appbar;

import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

PreferredSizeWidget? computeAppBar(
  String pageId,
  LayoutProps? appBarLayout,
) {
  if (appBarLayout == null) {
    return null;
  }

  final utils = getIt<UtilsManager>();
  final pageData = getIt<ContextStateProvider>().contextData[pageId];

  if (appBarLayout.content == null) {
    return AppBar(
      title: UtilsManager.computeTWidgets(
        appBarLayout.title,
        pagePath: pageId,
        childData: const {},
      ),
      centerTitle: appBarLayout.alignment ?? true,
      bottom: appBarLayout.appBarBottom == null
          ? null
          : PreferredSize(
              preferredSize: Size.fromHeight(
                utils.computeSizeValue(
                      appBarLayout.appBarBottom?["height"],
                      pageData,
                    ) ??
                    32,
              ),
              child: UtilsManager.computeTWidgets(
                LayoutProps.fromJson(appBarLayout.appBarBottom?["child"]),
                pagePath: pageId,
                childData: const {},
              )!,
            ),
      elevation: appBarLayout.elevation ?? 4,
      shape: ThemeDecoder.decodeShapeBorder(appBarLayout.shapeBorder?.toJson()),
      shadowColor: ThemeDecoder.decodeColor(appBarLayout.shadowColor),
      backgroundColor: ThemeDecoder.decodeColor(appBarLayout.backgroundColor),
      // foregroundColor: ThemeDecoder.decodeColor(appBarConfig.foregroundColor),
      // surfaceTintColor: ThemeDecoder.decodeColor(appBarConfig.surfaceTintColor),

      leading: UtilsManager.computeTWidgets(
        appBarLayout.leading,
        pagePath: pageId,
        childData: const {},
      ),
      actions: UtilsManager.computeListTWidgets(
        appBarLayout.actions,
        pagePath: pageId,
        childData: const {},
      ),
    );
  }

  var customContent = appBarLayout.content;
  return PreferredSize(
    preferredSize: Size.fromHeight(customContent?.height ?? 120),
    child: TWidgets(
      layout: customContent!,
      pagePath: pageId,
      childData: const {},
    ),
  );
}
