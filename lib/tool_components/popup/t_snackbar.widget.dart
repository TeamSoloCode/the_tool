import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TSnackBar extends TStatelessWidget {
  TSnackBar(TWidgetProps twidget) : super(twidget);
  static const _defaultDuration = Duration(seconds: 4);
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
      _scaffoldFeatureController;

  SnackBar _computeSnackbar(LayoutProps props) {
    return SnackBar(
      action: _buildSnackBarAction(props.labelText, props.onClick),
      duration: props.duration == null
          ? _defaultDuration
          : Duration(seconds: props.duration!),
      dismissDirection: UtilsManager.getDismissDirectionFromString(
        props.dismissDirection,
      ),
      backgroundColor: ThemeDecoder.decodeColor(props.backgroundColor),
      elevation: props.elevation,
      width: props.width,
      margin: ThemeDecoder.decodeEdgeInsetsGeometry(props.margin),
      padding: ThemeDecoder.decodeEdgeInsetsGeometry(props.padding),
      shape: ThemeDecoder.decodeShapeBorder(props.shapeBorder?.toJson()),
      content: UtilsManager.computeTWidgets(
        props.child,
        pagePath: pagePath,
        childData: childData,
      )!,
    );
  }

  void _showSnackBar(BuildContext context, LayoutProps? props) {
    var name = props?.name;
    if (name == null) {
      throw Exception(
        "SnackBar widget must to have 'name' property ($pagePath)",
      );
    }

    final showSnackBar = UtilsManager.isTruthy(getContexData()[name]);

    if (!showSnackBar) {
      _scaffoldFeatureController?.close();
      return;
    }

    var contextState = getIt<ContextStateProvider>();
    var scaffoldMessengerKey = contextState.scaffoldMessengerKey;

    if (scaffoldMessengerKey != null) {
      _scaffoldFeatureController =
          scaffoldMessengerKey.currentState!.showSnackBar(
        _computeSnackbar(props!),
      );
    } else {
      _scaffoldFeatureController = ScaffoldMessenger.of(context).showSnackBar(
        _computeSnackbar(props!),
      );
    }

    _scaffoldFeatureController!.closed.then((value) {
      _scaffoldFeatureController = null;
      setPageData({name: false});
    });
  }

  SnackBarAction? _buildSnackBarAction(
    String? labelText,
    String? onClick,
  ) {
    if (labelText == null) {
      return null;
    } else {
      return SnackBarAction(
        label: labelText,
        onPressed: () {
          if (onClick == null) return;
          executeJSWithPagePath(onClick, []);
        },
      );
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (props != null && _scaffoldFeatureController == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSnackBar(context, props);
      });
    }
    return const Offstage();
  }
}
