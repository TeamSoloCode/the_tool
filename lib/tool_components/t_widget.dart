import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
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
  String? prevBindingValues;
  var hasBindingValue = false;
  var hasThemeBindingValue = false;
  var propsHasAdaptiveScreenUnit = false;
  int? _prevThemeRefreshToken;

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
      context.select((ContextStateProvider value) {
        var newPageData =
            value.contextData[path] ?? UtilsManager.emptyMapStringDynamic;
        var dependenciesChanged = false;

        dependenciesChanged = isTWidgetDependenciesChanged(
          newPageData,
          providedPagePath: path,
        );

        if (!dependenciesChanged) {
          return _contextData;
        }

        _contextData = newPageData;
        return newPageData;
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

    if (prevProps != null &&
        !hasBindingValue &&
        !propsHasAdaptiveScreenUnit &&
        !mediaScreenApplied &&
        _prevThemeRefreshToken == themeProvider.themeRefreshToken) {
      return _contextData;
    }

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
    // var depsAsString =
    //     "${providedPagePath ?? pagePath}_${widgetBindingStrings.toString()}";
    // var caheValue =
    //     contextStateProvider.cacheCheckTWidgetDepsChanged[depsAsString];

    // if (caheValue != null) {
    //   return caheValue;
    // }
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

    var newBindingValuesAsJSON = jsonEncode(newBindingValues);
    var isChanged = newBindingValuesAsJSON != prevBindingValues;

    if (isChanged) {
      prevBindingValues = newBindingValuesAsJSON;
    }

    // Cache the result for later use
    // contextStateProvider.updateCacheCheckTWidgetDepsChanged(
    //   depsAsString,
    //   isChanged,
    // );
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
        isPropsHasAdaptiveScreenUnit: () {
          propsHasAdaptiveScreenUnit = true;
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
        isPropsHasAdaptiveScreenUnit: () {
          propsHasAdaptiveScreenUnit = true;
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
