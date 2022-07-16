import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/theme_provider.dart';

class ShouldWidgetUpdate extends StatefulWidget {
  ShouldWidgetUpdate({
    Key? key,
    required this.builder,
    required this.shouldWidgetUpdate,
  }) : super(key: key);

  Widget Function(BuildContext context) builder;
  bool shouldWidgetUpdate;

  @override
  State<ShouldWidgetUpdate> createState() => _ShouldWidgetUpdateState();
}

class _ShouldWidgetUpdateState extends State<ShouldWidgetUpdate> {
  Widget? widgetSnapshot;
  ThemeMode? prevThemeMode;

  @override
  Widget build(BuildContext context) {
    var currentThemeMode = context.read<ThemeProvider>().currentThemeMode;

    if (widget.shouldWidgetUpdate ||
        widgetSnapshot == null ||
        prevThemeMode != currentThemeMode) {
      prevThemeMode = currentThemeMode;
      widgetSnapshot = RepaintBoundary(
        child: widget.builder(context),
      );
    }

    return widgetSnapshot!;
  }
}
