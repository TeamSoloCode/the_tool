import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Row extends TStatelessWidget {
  T_Row({
    Key? key,
    required widgetProps,
    required pagePath,
    childData = const {},
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          childData: childData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  List<Widget> _computeChildren(
    List<LayoutProps>? children,
    Map<String, dynamic> childData,
    BuildContext context,
  ) {
    var index = 0;
    return (children ?? []).map((child) {
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
    MediaQuery.of(context).size;
    var mainAxisAlignment = ThemeDecoder.decodeMainAxisAlignment(
          props?.mainAxisAlignment,
        ) ??
        MainAxisAlignment.start;

    snapshot = Row(
      key: getBindingKey(),
      mainAxisAlignment: mainAxisAlignment,
      children: _computeChildren(
        props?.children,
        childData,
        context,
      ),
    );

    if (props?.scrollable == true) {
      snapshot = ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: snapshot,
        ),
      );
    }

    return snapshot;
  }
}
