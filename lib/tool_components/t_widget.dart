import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late final String? widgetUuid;

  T_DrawerProps? drawerProps;
  T_LayoutBuilderProps? layoutBuilder;
  LayoutProps? props;
  LayoutProps? prevProps;
  LayoutProps? appliedMediaScreen;
  LayoutProps? prevSelectedMediaScreen;
  Widget snapshot = const Offstage();
  Map<String, dynamic> _contextData = {};
  final Set<String> widgetBindingStrings = {};
  List<dynamic> prevBindingValues = [];
  var hasBindingValue = false;
  int? _themeRefreshToken;
  int? _prevThemeRefreshToken;
  int? _dataChangedToken;

  bool mediaScreenApplied = false;

  int? watchContextState(BuildContext context, {String? providedPagePath}) {
    var path = providedPagePath ?? pagePath;

    _themeRefreshToken = context.select(
      (ThemeProvider theme) {
        return theme.themeRefreshToken;
      },
    );

    if (hasBindingValue) {
      _dataChangedToken = context.select((ContextStateProvider value) {
        var newPageData =
            value.contextData[path] ?? UtilsManager.emptyMapStringDynamic;
        var dependenciesChanged = false;

        dependenciesChanged = isTWidgetDependenciesChanged(
          newPageData,
          providedPagePath: path,
        );

        if (!dependenciesChanged) {
          return _dataChangedToken;
        }

        _contextData = newPageData;
        return value.dataChangedToken;
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

    var propsHasUnit = utils.isPropsHasAdaptiveScreenUnit(widgetProps);

    if (prevProps != null &&
        !hasBindingValue &&
        !propsHasUnit &&
        !mediaScreenApplied &&
        _prevThemeRefreshToken == _themeRefreshToken) {
      return _dataChangedToken;
    }

    mediaScreenApplied = false;
    props = utils.computeWidgetProps(
      appliedMediaScreen ?? widgetProps,
      childData.isEmpty ? _contextData : childData,
    );

    prevProps = props;
    _prevThemeRefreshToken = _themeRefreshToken;

    return _dataChangedToken;
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

    var newBindingValues = widgetBindingStrings.map((widgetBindingString) {
      String bindingField = widgetBindingString;

      var rootData = getIt<ContextStateProvider>().rootPageData;
      var useRootData = bindingField.startsWith(UtilsManager.rootPrefix);
      var selectedData = useRootData ? rootData : contextData;

      if (useRootData) {
        bindingField = bindingField.substring(UtilsManager.rootPrefix.length);
      }

      var bindingData = gato.get(selectedData, bindingField);

      return bindingData;
    }).toList();

    var isChanged = !const DeepCollectionEquality().equals(
      newBindingValues,
      prevBindingValues,
    );

    if (isChanged) {
      prevBindingValues = newBindingValues;
    }

    // Cache the result for later use
    // contextStateProvider.updateCacheCheckTWidgetDepsChanged(
    //   depsAsString,
    //   isChanged,
    // );
    return isChanged;
  }

  Future<dynamic> executeJSWithPagePath(String jsCode) async {
    return await utils.evalJS?.executeJS(jsCode, pagePath);
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
  TWidget({
    Key? key,
    required LayoutProps widgetProps,
    childData,
    required pagePath,
    required widgetUuid,
    T_DrawerProps? drawerProps,
    T_LayoutBuilderProps? layoutBuilder,
  }) : super(key: key) {
    this.widgetProps = widgetProps;
    this.childData = childData;
    this.pagePath = pagePath;
    this.widgetUuid = widgetUuid;
    this.drawerProps = drawerProps;
    this.layoutBuilder = layoutBuilder;

    _contextData = getIt<ContextStateProvider>().contextData[pagePath] ??
        UtilsManager.emptyMapStringDynamic;

    if (prevProps == null) {
      hasBindingValue = utils.hasBindingValue(
        widgetProps,
        updateWidgetBindingStrings,
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
  TStatelessWidget({
    Key? key,
    required widgetProps,
    childData,
    required pagePath,
    required widgetUuid,
  }) : super(key: key) {
    this.widgetProps = widgetProps;
    this.childData = childData;
    this.pagePath = pagePath;
    this.widgetUuid = widgetUuid;

    _contextData = getIt<ContextStateProvider>().contextData[pagePath] ??
        UtilsManager.emptyMapStringDynamic;
    if (prevProps == null) {
      hasBindingValue = utils.hasBindingValue(
        widgetProps,
        updateWidgetBindingStrings,
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
