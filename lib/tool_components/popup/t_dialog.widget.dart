import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TAlertDialog extends TStatelessWidget {
  TAlertDialog(TWidgetProps twidget) : super(twidget);

  bool _showing = false;

  Widget _computeAlertDialog(BuildContext context, LayoutProps widgetProps) {
    return AlertDialog(
      key: getBindingKey(),
      title: UtilsManager.computeTWidgets(
        widgetProps.title,
        pagePath: pagePath,
        childData: childData,
      ),
      content: UtilsManager.computeTWidgets(
        widgetProps.content,
        pagePath: pagePath,
        childData: childData,
      ),
      actions: UtilsManager.computeListTWidgets(
        widgetProps.actions,
        pagePath: pagePath,
        childData: childData,
      ),
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
