import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';

class ShowFlexibleBottomSheet {
  BuildContext context;
  FlexibleDraggableScrollableWidgetBuilder builder;
  DraggableScrollableController? draggableScrollableController;
  double? minHeight;
  double? initHeight;
  double? maxHeight;
  bool isCollapsible = true;
  bool isDismissible = true;
  bool isExpand = true;
  bool useRootNavigator = false;
  bool isModal = true;
  List<double>? anchors;
  Color? keyboardBarrierColor;
  Color? bottomSheetColor;
  Color? barrierColor;
  Duration? duration;
  bool isSafeArea = false;
  BoxDecoration? decoration;

  ShowFlexibleBottomSheet({
    required this.context,
    required this.builder,
    this.draggableScrollableController,
    this.minHeight,
    this.initHeight,
    this.maxHeight,
    this.isCollapsible = true,
    this.isDismissible = true,
    this.isExpand = true,
    this.useRootNavigator = false,
    this.isModal = true,
    this.anchors,
    this.keyboardBarrierColor,
    this.bottomSheetColor,
    this.barrierColor,
    this.duration,
    this.isSafeArea = false,
    this.decoration,
  });

  void show() {
    showFlexibleBottomSheet(
      context: context,
      builder: builder,
      draggableScrollableController: draggableScrollableController,
      minHeight: minHeight,
      initHeight: initHeight,
      maxHeight: maxHeight,
      isCollapsible: isCollapsible,
      isDismissible: isDismissible,
      isExpand: isExpand,
      useRootNavigator: useRootNavigator,
      isModal: isModal,
      anchors: anchors,
      keyboardBarrierColor: keyboardBarrierColor,
      bottomSheetColor: bottomSheetColor,
      barrierColor: barrierColor,
      duration: duration,
      isSafeArea: isSafeArea,
      decoration: decoration,
    );
  }
}
