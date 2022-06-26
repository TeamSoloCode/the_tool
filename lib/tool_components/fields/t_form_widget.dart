import 'dart:developer';

import 'package:eventify/eventify.dart' as eventify;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

class T_Form extends T_Widget {
  final String pageName;

  T_Form({
    Key? key,
    required executeJS,
    required widgetProps,
    required contextData,
    required this.pageName,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
          contextData: contextData,
        );

  @override
  State<T_Form> createState() => _T_FormState();
}

class _T_FormState extends State<T_Form> {
  final _formKey = GlobalKey<FormBuilderState>();
  UtilsManager utils = getIt<UtilsManager>();
  eventify.EventCallback cb = (ev, cont) {
    if (null != ev) {
      log("EventCallback ${ev.eventName}");
    }
  };
  late eventify.Listener listener;

  @override
  void initState() {
    listener = utils.emitter.on(widget.widgetProps["name"], context, cb);
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    utils.emitter.off(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(
        widget.widgetProps["name"] != null, "Form need to have name property");

    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: T_Widgets(
        layout: widget.widgetProps["child"] ?? {},
        pagePath: widget.pageName,
        contextData: widget.contextData,
      ),
    );
  }
}
