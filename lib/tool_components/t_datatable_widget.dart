import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widget.dart';

class T_DataTable extends TWidget {
  T_DataTable({
    Key? key,
    required widgetProps,
    required contextData,
    required pagePath,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  State<T_DataTable> createState() => _T_DataTableState();
}

class _T_DataTableState extends TStatefulWidget<T_DataTable> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    throw UnimplementedError();
  }
}
