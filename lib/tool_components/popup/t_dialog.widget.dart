import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_tool/page_utils/debouncer.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TAlertDialog extends TStatelessWidget {
  TAlertDialog(TWidgetProps twidget) : super(twidget);

  bool _showing = false;

  final _debounceShowDialog = Debouncer(
    delay: const Duration(milliseconds: 100),
  );

  Widget? _computeTWidgets(LayoutProps? widgetProps) {
    if (widgetProps == null) {
      return null;
    }

    return TWidgets(
      layout: widgetProps,
      pagePath: pagePath,
      childData: childData,
    );
  }

  List<Widget>? _computeListTWidgets(List<LayoutProps>? widgetProps) {
    if (widgetProps == null) {
      return null;
    }
    var index = 0;

    List<Widget> widgets = [];
    for (var widgetProp in widgetProps) {
      widgets.add(
        TWidgets(
          key: ValueKey(index++),
          layout: widgetProp,
          pagePath: pagePath,
          childData: childData,
        ),
      );
    }

    return widgets;
  }

  Widget _computeAlertDialog(BuildContext context, LayoutProps widgetProps) {
    return AlertDialog(
      key: getBindingKey(),
      title: _computeTWidgets(widgetProps.title),
      content: _computeTWidgets(widgetProps.content),
      actions: _computeListTWidgets(widgetProps.actions),
    );
  }

  void _onAlertDialogClose(Future<dynamic> futureDialog) {
    final dialogName = widgetProps.name;
    futureDialog.then((value) {
      setPageData({dialogName!: false});
      _showing = false;
    });
  }

  void _showAlerDialog(BuildContext context, LayoutProps widgetProps) {
    _debounceShowDialog.run(() {
      var alertDialog = showDialog(
        context: context,
        builder: (BuildContext context) {
          return _computeAlertDialog(context, widgetProps);
        },
        // barrierColor: Colors.amber,
        // barrierDismissible: false,
      );

      _showing = true;
      _onAlertDialogClose(alertDialog);
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    final popupName = widgetProps.name;
    final showPopup = UtilsManager.isTruthy(getContexData()[popupName]);

    if (props != null) {
      if (showPopup) {
        _showAlerDialog(context, props!);
      } else if (_showing) {
        Modular.to.pop();
      }
    }

    return snapshot;
  }
}
