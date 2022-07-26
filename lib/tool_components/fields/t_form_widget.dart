import 'dart:convert';
import 'dart:developer';
import 'package:eventify/eventify.dart' as eventify;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';

class T_Form extends T_Widget {
  T_Form({
    Key? key,
    required widgetProps,
    required contextData,
    required pagePath,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  State<T_Form> createState() => _T_FormState();
}

class _T_FormState extends State<T_Form> {
  final _formKey = GlobalKey<FormBuilderState>();
  UtilsManager utils = getIt<UtilsManager>();

  Map<String, FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>?
      prevFields;

  late eventify.Listener listener;

  @override
  void initState() {
    listener = utils.emitter.on(
      widget.widgetProps.name ?? "",
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
    return (event, cont) {
      log("Form EventCallback ${event.eventName} ${event.eventData}");
      var data = json.decode(event.eventData as String);
      switch (data["action"]) {
        case "validate":
          var isValid = _formKey.currentState?.validate();
          utils.evalJS?.emitFormActionResponse(
            data["actionId"],
            isValid,
          );

          return;
        case "reset":
          var fields = _formKey.currentState?.fields;
          fields?.forEach((key, field) {
            field.reset();
          });
          return;
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    widget.watchContextState(context);

    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;
    LayoutProps? _prevProps = widget.prevProps;

    if (_props == _prevProps) {
      return _snapshot;
    }

    if (_props?.hidden == true) {
      return const SizedBox.shrink();
    }

    _prevProps = _props;

    assert(
      _props?.name != null,
      "Form need to have name property",
    );

    var fields = _formKey.currentState?.fields;
    fields?.forEach((key, field) {
      field.setValue(widget.parentData[key]);
    });

    _snapshot = FormBuilder(
      key: _formKey,
      autoFocusOnValidationFailure: true,
      autovalidateMode: AutovalidateMode.disabled,
      child: T_Widgets(
        layout: _props?.child ?? const LayoutProps(),
        pagePath: widget.pagePath,
        contextData: widget.parentData,
      ),
    );

    return _snapshot;
  }
}
