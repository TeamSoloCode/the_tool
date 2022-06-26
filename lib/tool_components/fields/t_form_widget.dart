import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

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

  @override
  Widget build(BuildContext context) {
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
