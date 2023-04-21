import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/resize_provider.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/t_widget_interface/drawer_props/drawer_props.dart';
import 'package:the_tool/t_widget_interface/layout_builder_props/layout_builder_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/t_widget_interface/media_screen_only/media_screen_only.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:gato/gato.dart' as gato;
import 'package:uuid/uuid.dart';

mixin BaseStateWidget on Widget {
  late final LayoutProps widgetProps;
  late final Map<String, dynamic> childData;
  late final String pagePath;
  final UtilsManager utils = getIt<UtilsManager>();
  final contextStateProvider = getIt<ContextStateProvider>();
  final themeProvider = getIt<ThemeProvider>();
  late final String widgetUuid;

  T_DrawerProps? drawerProps;
  T_LayoutBuilderProps? layoutBuilder;
  LayoutProps? props;
  LayoutProps? prevProps;
  LayoutProps? appliedMediaScreen;
  LayoutProps? prevSelectedMediaScreen;
  Widget snapshot = const Offstage();
  Map<String, dynamic> _contextData = {};
  final Set<String> widgetBindingStrings = {};
  List<dynamic>? prevBindingValues;
  var hasBindingValue = false;
  var hasThemeBindingValue = false;
  var propsHasAdaptiveScreenUnit = false;
  int? _prevThemeRefreshToken;
  int? _prevResizeToken;

  bool mediaScreenApplied = false;

  Map<String, dynamic> watchContextState(BuildContext context,
      {String? providedPagePath}) {
    var path = providedPagePath ?? pagePath;

    // if (hasThemeBindingValue) {
    //   Theme.of(context);
    // }

    context.select(
      (ThemeProvider theme) {
        return theme.themeRefreshToken;
      },
    );

    // print("abcd hasBindingValue ${widgetProps.type} ");

    if (hasBindingValue) {
      context.select((ContextStateProvider value) async {
        var newPageData =
            value.contextData[path] ?? UtilsManager.emptyMapStringDynamic;

        var dependenciesChanged = isTWidgetDependenciesChanged(
          newPageData,
          providedPagePath: path,
        );

        if (!dependenciesChanged) {
          return false;
        }

        _contextData = newPageData;

        if (prevProps != null) {
          // debugPrint("abcd computeWidgetProps1");
          // This is run when:
          //   - dependencies in widget props changed
          props = utils.computeWidgetProps(
            appliedMediaScreen ?? widgetProps,
            getContexData(),
          );

          prevProps = props;
        }

        return const Uuid().v4();
      });
    }

    /**
     * Apply mediaScreenOnly into widget props
     */
    if (widgetProps.mediaScreenOnly != null) {
      var selectedMediaScreen = computePropsFromMediaScreen(
        context,
        _contextData,
        widgetProps.mediaScreenOnly!,
      );

      appliedMediaScreen = selectedMediaScreen != null
          ? widgetProps.merge(selectedMediaScreen)
          : null;

      if (!const DeepCollectionEquality()
          .equals(prevSelectedMediaScreen, selectedMediaScreen)) {
        prevSelectedMediaScreen = selectedMediaScreen;
        mediaScreenApplied = true;
      }
    }

    if (kIsWeb) {
      if (["container", "table", "clickable"].contains(widgetProps.type)) {
        var resizeRefreshKey = context.select((ResizeProvider resizeProvider) {
          if (_prevResizeToken == null ||
              _prevResizeToken == resizeProvider.resizeRefreshKey) {
            return resizeProvider.resizeRefreshKey;
          }

          props = utils.computeWidgetProps(
            appliedMediaScreen ?? widgetProps,
            getContexData(),
          );

          prevProps = props;
          return resizeProvider.resizeRefreshKey;
        });

        _prevResizeToken = resizeRefreshKey;
      }
    }

    if (prevProps != null &&
        !mediaScreenApplied &&
        _prevThemeRefreshToken == themeProvider.themeRefreshToken) {
      return _contextData;
    }

    // This is run when:
    //   - first render
    //   - mediaScreen changed
    //   - theme changed
    props = utils.computeWidgetProps(
      appliedMediaScreen ?? widgetProps,
      getContexData(),
    );

    mediaScreenApplied = false;
    prevProps = props;
    _prevThemeRefreshToken = themeProvider.themeRefreshToken;

    return _contextData;
  }

  LayoutProps? computePropsFromMediaScreen(
    BuildContext context,
    Map<String, dynamic> contextData,
    List<T_MediaScreenOnlyProps> mediaScreen,
  ) {
    var mediaQuery = MediaQuery.of(context);
    var margedClassesMediaScreen = mediaScreen.map((media) {
      return utils.themeProvider
          .margerClassesIntoMediaScreen(media, contextData);
    }).toList();

    var applyProps = utils.getMediaScreeStyle(
      mediaQuery,
      contextData,
      margedClassesMediaScreen,
    );

    return applyProps;
  }

  void updateWidgetBindingStrings(String bindingString) {
    widgetBindingStrings.add(bindingString);
  }

  bool isTWidgetDependenciesChanged(
    Map<String, dynamic> contextData, {
    String? providedPagePath,
  }) {
    final rootData = getIt<ContextStateProvider>().rootPageData;
    const rootPrefix = UtilsManager.rootPrefix;

    var newBindingValues = widgetBindingStrings.map((widgetBindingString) {
      var useRootData = widgetBindingString.startsWith(rootPrefix);
      var selectedData = useRootData ? rootData : contextData;

      var bindingField = useRootData
          ? widgetBindingString.substring(rootPrefix.length)
          : widgetBindingString;

      return gato.get(selectedData, bindingField);
    }).toList();

    var isChanged = !const DeepCollectionEquality()
        .equals(newBindingValues, prevBindingValues);

    if (isChanged) {
      prevBindingValues = newBindingValues;
    }

    return isChanged;
  }

  Future<dynamic> executeJSWithPagePath(String jsCode) async {
    return await utils.evalJS?.executeAsyncJS(jsCode, pagePath);
  }

  Key? getBindingKey() {
    var rawKey = widgetProps.key;
    if (rawKey == null) return key;
    if (UtilsManager.isValueBinding(rawKey)) {
      var bindingValue = utils.bindingValueToText(childData, rawKey);
      return ValueKey(bindingValue);
    }

    return ValueKey(rawKey);
  }

  Future<void> setPageData(Map<String, dynamic> newData) async {
    await executeJSWithPagePath(
      "setPageData(JSON.parse(`${json.encode(newData)}`));",
    );
  }

  Map<String, dynamic> getContexData() {
    return childData.isEmpty ? _contextData : childData;
  }
}

abstract class TWidget extends StatefulWidget with BaseStateWidget {
  TWidget(TWidgetProps twidget) : super(key: twidget.key) {
    widgetProps = twidget.widgetProps;
    childData = twidget.childData;
    pagePath = twidget.pagePath;
    widgetUuid = twidget.widgetUuid;
    drawerProps = twidget.drawerProps;
    layoutBuilder = twidget.layoutBuilder;

    _contextData = getIt<ContextStateProvider>().contextData[pagePath] ??
        UtilsManager.emptyMapStringDynamic;

    if (prevProps == null) {
      hasBindingValue = utils.hasBindingValue(
        widgetProps,
        updateWidgetBindingStrings,
        hasThemeBindingValue: () {
          hasThemeBindingValue = true;
        },
      );
    }
  }
}

abstract class TStatefulWidget<Page extends TWidget> extends State<Page>
    with AutomaticKeepAliveClientMixin {
  Widget buildWidget(BuildContext context);
  bool isWatchContextState = true;

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (isWatchContextState) {
      widget.watchContextState(context);
    }

    if (widget.props?.hidden == true) {
      return const Offstage();
    }

    if (widget.props == null) {
      return widget.snapshot;
    }

    return buildWidget(context);
  }
}

abstract class TStatelessWidget extends StatelessWidget with BaseStateWidget {
  TStatelessWidget(TWidgetProps twidget) : super(key: twidget.key) {
    widgetProps = twidget.widgetProps;
    childData = twidget.childData;
    pagePath = twidget.pagePath;
    widgetUuid = twidget.widgetUuid;

    _contextData = getIt<ContextStateProvider>().contextData[pagePath] ??
        UtilsManager.emptyMapStringDynamic;

    if (prevProps == null) {
      hasBindingValue = utils.hasBindingValue(
        widgetProps,
        updateWidgetBindingStrings,
        hasThemeBindingValue: () {
          hasThemeBindingValue = true;
        },
      );
    }
  }

  Widget buildWidget(BuildContext context);
  bool isWatchContextState = true;

  @override
  Widget build(BuildContext context) {
    if (isWatchContextState) {
      watchContextState(context);
    }

    if (props?.hidden == true) {
      return const Offstage();
    }

    if (props == null) {
      return snapshot;
    }

    return buildWidget(context);
  }
}
