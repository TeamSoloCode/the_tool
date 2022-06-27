import 'dart:developer';
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:eventify/eventify.dart' as eventify;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:the_tool/page_utils/should_update.widget.dart';
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
  Map<String, dynamic> prevWidgetProps = {};
  Map<String, dynamic> widgetProps = {};
  Map<String, FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>?
      prevFields;

  late eventify.Listener listener;

  @override
  void initState() {
    listener = utils.emitter.on(
      widget.widgetProps["name"],
      context,
      formAction(),
    );
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    utils.emitter.off(listener);
    super.dispose();
  }

  eventify.EventCallback formAction() {
    return (ev, cont) {
      log("Form EventCallback ${ev.eventName} ${ev.eventData}");
      switch (ev.eventData) {
        case "submit":
          _formKey.currentState?.validate();
          return;
        case "reset":
          _formKey.currentState?.reset();
          return;
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.widgetProps["name"] != null,
      "Form need to have name property",
    );

    return ShouldWidgetUpdate(
      builder: (context) {
        prevWidgetProps = widgetProps;
        prevFields = _formKey.currentState?.fields;
        return FormBuilder(
          key: _formKey,
          autoFocusOnValidationFailure: true,
          autovalidateMode: AutovalidateMode.disabled,
          child: T_Widgets(
            layout: widget.widgetProps["child"] ?? {},
            pagePath: widget.pageName,
            contextData: widget.contextData,
          ),
        );
      },
      shouldWidgetUpdate: shouldUpdate(),
    );
  }

  bool shouldUpdate() {
    var isFieldChanged = false;
    var fields = _formKey.currentState?.fields;
    fields?.forEach((key, field) {
      var isEqual = false;
      var value = field.value;
      log("abcd _formKey.currentState $key ${value}");
      if (value is Map || value is List) {
        isEqual = const DeepCollectionEquality().equals(
          value,
          prevFields?[key]?.value,
        );
      } else {
        isEqual = value == prevFields?[key]?.value;
      }

      if (!isEqual) {
        isFieldChanged = true;
      }
    });

    var shouldUpdate = isFieldChanged ||
        !const DeepCollectionEquality().equals(
          prevWidgetProps,
          widgetProps,
        );

    return shouldUpdate;
  }
}
