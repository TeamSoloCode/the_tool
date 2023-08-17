import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TDismissable extends TWidget {
  TDismissable(TWidgetProps twidget) : super(twidget);

  @override
  State<TDismissable> createState() => _TDismissableState();
}

class _TDismissableState extends TStatefulWidget<TDismissable> {
  late Key widgetKey;

  @override
  void initState() {
    widgetKey = widget.getBindingKey()!;
    super.initState();
  }

  Widget _computeWidget(LayoutProps props) {
    if (props.key == null) {
      throw Exception("\"dismissable\" widget must have a key");
    }

    if (props.child == null) {
      throw Exception("\"dismissable\" widget must have a child");
    }

    return Dismissible(
      key: widgetKey,
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        child: Icon(Icons.archive),
      ),
      direction: UtilsManager.getDismissDirectionFromString(
        props.dismissDirection,
        defaultValue: DismissDirection.horizontal,
      ),
      // confirmDismiss: (direction) async {
      //   if (props.confirmDismiss != null) {
      //     return props.confirmDismiss!(direction);
      //   }

      //   return true;
      // },
      // movementDuration: Duration(seconds: 10000),
      onUpdate: (details) {},
      child: UtilsManager.computeTWidgets(
        props.child,
        pagePath: widget.pagePath,
        childData: widget.childData,
      )!,
      onDismissed: (direction) {
        if (props.onDismissed != null) {
          widget.executeJSWithPagePath(props.onDismissed!, []);
        }
      },
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return _computeWidget(widget.props!);
  }
}
