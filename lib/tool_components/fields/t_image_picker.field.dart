import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TImagePickerField extends TWidget {
  TImagePickerField(TWidgetProps twidget) : super(twidget);

  @override
  State<TImagePickerField> createState() => _TImagePickerFieldState();
}

class _TImagePickerFieldState extends State<TImagePickerField> {
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

    print("abcd filename ${pickedFile.name}");

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

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _openGallery,
      child: const Text("Upload Image"),
    );
  }
}
