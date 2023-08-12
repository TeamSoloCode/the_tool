import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TDrawer extends TWidget {
  TDrawer(TWidgetProps twidget) : super(twidget);

  @override
  State<TDrawer> createState() => _TDrawerState();
}

class _TDrawerState extends TStatefulWidget<TDrawer> {
  late Future<void> _debounceLoadingBody;

  @override
  void initState() {
    _debounceLoadingBody = Future.delayed(const Duration(milliseconds: 100));
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (widget.props != null) {
      snapshot = Drawer(
        width: widget.props?.weight,
        child: FutureBuilder(
          future: _debounceLoadingBody,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TWidgets(
                layout: widget.props!,
                pagePath: widget.pagePath,
                childData: const {},
              );
            } else {
              return const Offstage();
            }
          },
        ),
      );
    }

    return snapshot;
  }
}
