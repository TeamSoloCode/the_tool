import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.extension.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TWrap extends TStatelessWidget {
  TWrap(TWidgetProps twidget) : super(twidget);

  List<Widget> _getChildren(BuildContext context) {
    var index = 0;
    List<LayoutProps> children = props?.children ?? [];
    return children.map((child) {
      index++;

      Widget item = TWidgets(
        key: ValueKey(index),
        layout: child,
        pagePath: pagePath,
        childData: childData,
      );

      if (child.flex != null) {
        var mediaScreen = child.mediaScreenOnly;
        if (mediaScreen != null) {
          var selectedMediaStyle =
              computePropsFromMediaScreen(context, childData, mediaScreen);
          child = child.merge(selectedMediaStyle);
        }
        if (child.type != "expanded") {
          item = Expanded(
            key: ValueKey(index),
            flex: child.flex ?? 1,
            child: item,
          );
        }
      }

      return item;
    }).toList();
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = props;

    if (_props != null) {
      snapshot = Wrap(
        key: getBindingKey(),
        children: _getChildren(context),
      );
    }

    return snapshot;
  }
}
