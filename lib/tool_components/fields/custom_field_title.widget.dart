import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTitle extends SingleChildRenderObjectWidget {
  final Widget child;

  const CustomTitle({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCustomTitle();
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderCustomTitle renderObject) {
    // Nothing to update for now
  }
}

class _RenderCustomTitle extends RenderShiftedBox {
  _RenderCustomTitle() : super(null);

  @override
  void performLayout() {
    child!.layout(constraints, parentUsesSize: true);
    size = child!.size;
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    if (child == null) {
      return 0;
    }

    final double? childBaseline = child!.getDistanceToActualBaseline(baseline);
    return childBaseline ?? 0;
  }
}
