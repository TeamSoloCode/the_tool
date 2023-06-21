// import 'package:flutter/material.dart';
// import 'package:form_builder_image_picker/form_builder_image_picker.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:json_theme/json_theme.dart';
// import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
// import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
// import 'package:the_tool/tool_components/t_widget.dart';
// import 'package:the_tool/twidget_props.dart';

// class TImagePickerField extends TWidget {
//   TImagePickerField(TWidgetProps twidget) : super(twidget);

//   @override
//   State<TImagePickerField> createState() => _TImagePickerFieldState();
// }

// class _TImagePickerFieldState extends TStatefulWidget<TImagePickerField>
//     with FieldMixin {
//   String? _errorMessage;

//   Widget _computeImagePickerField(
//     LayoutProps props,
//     Map<String, dynamic> contextData,
//   ) {
//     String? name = props.name;
//     if (name == null) {
//       throw Exception("Missing \"name\" in field image");
//     }

//     return FormBuilderImagePicker(
//       name: name,
//       decoration: computeFieldDecoration(
//         props,
//         thisWidget: widget,
//         errorMessage: _errorMessage,
//       ),
//       enabled: props.enabled ?? true,
//       maxImages: 1,
//       imageQuality: 100,
//       // placeholderImage: ,

//       iconColor: ThemeDecoder.decodeColor(props.color),
//       cameraLabel: Text("Avatar"),
//       cameraIcon: generateIcon(props.cameraIcon, widget) ??
//           const Icon(Icons.camera_enhance),
//       validator: FormBuilderValidators.compose([
//         ...computeFieldValidators(widget.props, contextData),
//         (dynamic value) {
//           _runValidationFunction();
//           return null;
//         }
//       ]),
//       onSaved: (dynamic value) {
//         _runValidationFunction();
//       },
//     );
//   }

//   void _runValidationFunction() async {
//     _errorMessage =
//         "checking..."; // this to prevent form validate pass the field before it validated
//     String? errorMessage = await runValidationFunction(thisWidget: widget);
//     setState(() {
//       _errorMessage = errorMessage;
//     });
//   }

//   @override
//   Widget buildWidget(BuildContext context) {
//     LayoutProps? _props = widget.props;

//     if (_props != null) {
//       widget.snapshot =
//           _computeImagePickerField(_props, widget.getContexData());
//     }
//     return widget.snapshot;
//   }
// }
