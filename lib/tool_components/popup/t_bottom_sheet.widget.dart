import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/flexible_bottom_sheet.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';
import 'package:eventify/eventify.dart' as eventify;

class TBottomSheet extends TWidget {
  TBottomSheet(TWidgetProps twidget) : super(twidget);

  @override
  State<TBottomSheet> createState() => _TBottomSheetState();
}

class _TBottomSheetState extends TStatefulWidget<TBottomSheet> {
  late eventify.Listener listener;
  @override
  void initState() {
    final popupName = widget.widgetProps.name;

    if (popupName == null) {
      throw Exception("${widget.widgetProps.type} must have 'name' property");
    }

    listener = widget.utils.emitter.on(
      "popup:${widget.pagePath}:$popupName",
      context,
      _bottomSheetEvent(),
    );

    super.initState();
  }

  eventify.EventCallback _bottomSheetEvent() {
    return (event, cont) async {
      var data = jsonDecode(event.eventData as String);
      switch (data["action"]) {
        case "show":
          final popupName = widget.widgetProps.name;

          var flexibleBottomSheet = getIt<ContextStateProvider>()
                  .popupWidgets["${widget.pagePath}:$popupName"]
              as ShowFlexibleBottomSheet;

          flexibleBottomSheet.show();

          widget.utils.evalJS?.emitFormActionResponse(data["actionId"], null);
          return;
      }
    };
  }

  @override
  void dispose() {
    listener.cancel();
    widget.utils.emitter.off(listener);

    final popupName = widget.widgetProps.name;

    getIt<ContextStateProvider>().unregisterPopupWidgets(
      pagePath: widget.pagePath,
      popupName: popupName!,
    );

    super.dispose();
  }

  Widget _computeBottomSheet(LayoutProps widgetProps) {
    final popupName = widgetProps.name;

    var flexibleBottomSheet = ShowFlexibleBottomSheet(
      context: context,
      builder: (context, scrollController, bottomSheetOffset) {
        return const Text("This is the test bottom sheet");
      },
    );

    getIt<ContextStateProvider>().registerPopupWidgets(
      pagePath: widget.pagePath,
      popupName: popupName!,
      registerPopupWidget: flexibleBottomSheet,
    );

    return const Offstage();
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = _computeBottomSheet(_props);
    }

    return _snapshot;
  }
}
