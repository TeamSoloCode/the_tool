import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Column extends TStatelessWidget {
  T_Column(TWidgetProps twidget) : super(twidget);

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

        item = Expanded(
          key: ValueKey(index),
          flex: child.flex ?? 1,
          child: item,
        );
      }

      return item;
    }).toList();
  }

  @override
  Widget buildWidget(BuildContext context) {
    var mainAxisAlignment = ThemeDecoder.decodeMainAxisAlignment(
          props?.mainAxisAlignment,
        ) ??
        MainAxisAlignment.start;

    if (props != null) {
      snapshot = Column(
        key: getBindingKey(),
        mainAxisAlignment: mainAxisAlignment,
        children: _getChildren(context),
      );

      if (props?.scrollable == true) {
        snapshot = ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: snapshot,
          ),
        );
      }
    }

    return snapshot;
  }
}
