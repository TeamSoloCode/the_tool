import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/debouncer.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/flexible_bottom_sheet.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TBottomSheet extends TWidget {
  TBottomSheet(TWidgetProps twidget) : super(twidget);

  @override
  State<TBottomSheet> createState() => _TBottomSheetState();
}

class _TBottomSheetState extends TStatefulWidget<TBottomSheet> {
  var _built = false;
  var _showing = false;
  final _debounceShowButtomSheet = Debouncer(
    delay: const Duration(milliseconds: 100),
  );

  @override
  void initState() {
    final popupName = widget.widgetProps.name;

    if (popupName == null) {
      throw Exception("${widget.widgetProps.type} must have 'name' property");
    }

    super.initState();
  }

  void _onBottomSheetClosed(Future<void>? bottomSheet) {
    final popupName = widget.widgetProps.name;
    bottomSheet?.then((value) {
      widget.setPageData({popupName!: false});
      _showing = false;
    });
  }

  void _showBottomSheet() {
    final popupName = widget.widgetProps.name;
    final showPopup = UtilsManager.isTruthy(widget.getContexData()[popupName]);

    if (showPopup && !_showing) {
      final eventName = "${widget.pagePath}:$popupName";

      var flexibleBottomSheet = getIt<ContextStateProvider>()
          .popupWidgets[eventName] as ShowFlexibleBottomSheet;

      _debounceShowButtomSheet.run(() {
        final bottomSheet = flexibleBottomSheet.show();
        _onBottomSheetClosed(bottomSheet);
      });

      _showing = true;
    }

    if (!showPopup && _showing) {
      Navigator.of(context).pop();
    }
  }

  @override
  void didChangeDependencies() {
    _showBottomSheet();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // final popupName = widget.widgetProps.name;

    // getIt<ContextStateProvider>().unregisterPopupWidgets(
    //   pagePath: widget.pagePath,
    //   popupName: popupName!,
    // );

    super.dispose();
  }

  double? _checkSheetSizeValue(dynamic value, String propName) {
    if (value == null) return null;

    if (value is! num) {
      throw Exception(
          "bottom_sheet:$propName property should be between from 0 to 1");
    }

    if (value < 0 || value > 1) {
      throw Exception(
          "bottom_sheet: $propName property should be between from 0 to 1");
    }

    return value * 1.0;
  }

  Widget _computeBottomSheet(LayoutProps widgetProps) {
    final popupName = widgetProps.name;

    var height = _checkSheetSizeValue(widgetProps.height, "height");
    var maxHeight = _checkSheetSizeValue(widgetProps.maxHeight, "maxHeight");
    var minHeight = _checkSheetSizeValue(widgetProps.minHeight, "minHeight");

    var flexibleBottomSheet = ShowFlexibleBottomSheet(
      context: context,
      builder: (context, scrollController, bottomSheetOffset) {
        if (widgetProps.body == null) return const Offstage();

        return TWidgets(
          layout: widgetProps.body!,
          pagePath: widget.pagePath,
          childData: widget.childData,
        );
      },
      duration: widgetProps.duration == null
          ? null
          : Duration(
              milliseconds: widgetProps.duration!,
            ),
      bottomSheetColor: ThemeDecoder.decodeColor(widgetProps.backgroundColor),
      barrierColor: Colors.transparent,
      initHeight: height,
      maxHeight: maxHeight,
      minHeight: minHeight,
      // isSafeArea: UtilsManager.isTruthy(widgetProps.isSafeArea),
    );

    getIt<ContextStateProvider>().registerPopupWidgets(
      pagePath: widget.pagePath,
      popupName: popupName!,
      registerPopupWidget: flexibleBottomSheet,
    );
    _built = true;
    return const Offstage();
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = widget.props;

    if (_props != null && !_built) {
      widget.snapshot = _computeBottomSheet(_props);
    }

    return widget.snapshot;
  }
}
