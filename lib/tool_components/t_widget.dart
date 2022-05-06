import 'package:flutter/material.dart';

abstract class T_Widget extends StatelessWidget {
  Future<void> Function(String js) executeJS;
  Map<String, dynamic> widgetProps;
  Map<String, dynamic> contextData;

  T_Widget({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
    required this.contextData,
  });
}