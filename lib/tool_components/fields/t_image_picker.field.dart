import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TImagePickerField extends TWidget {
  TImagePickerField(TWidgetProps twidget) : super(twidget);

  @override
  State<TImagePickerField> createState() => _TImagePickerFieldState();
}

class _TImagePickerFieldState extends TStatefulWidget<TImagePickerField> {
  Image? image;

  final _clientAPI = getIt<APIClientManager>();

  void _openGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;
    late final Image imageTemp;
    if (kIsWeb) {
      imageTemp = Image.network(pickedFile.path);
    } else {
      imageTemp = Image.file(File(pickedFile.path));
    }

    setState(() {
      image = imageTemp;
    });

    if (image == null) return;
    late MultipartFile file;

    if (kIsWeb) {
      file = MultipartFile.fromBytes(
        (await pickedFile.readAsBytes()),
        contentType: MediaType.parse(
          pickedFile.mimeType ?? "png",
        ),
        filename: pickedFile.name,
      );
    } else {
      file = await MultipartFile.fromFile(
        pickedFile.path,
        filename: pickedFile.name,
      );
    }

    FormData formData = FormData.fromMap({
      "image": file,
    });

    final response = await _clientAPI.postImageFormData(formData);

    final onResponse = widget.widgetProps.onResponse;
    if (onResponse != null) {
      final responseData = response.data;
      widget.executeJSWithPagePath(onResponse, [responseData]);
    }
  }

  Widget _defaultPlaceholder(LayoutProps props) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[600] ?? const Color(0xFF000000),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                size: 48,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 8),
              Text(
                'Upload Image',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _computeImageChild(LayoutProps props) {
    if (props.child == null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          _defaultPlaceholder(props),
          image ?? const Offstage(),
        ],
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        TWidgets(
          layout: props.child!,
          pagePath: widget.pagePath,
          childData: widget.childData,
        ),
        image ?? const Offstage()
      ],
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = widget.props;

    if (_props != null) {
      widget.snapshot = GestureDetector(
        onTap: _openGallery,
        child: _computeImageChild(_props),
      );
    }

    return widget.snapshot;
  }
}
