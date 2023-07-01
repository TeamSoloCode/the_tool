import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
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
  File? image;

  final _clientAPI = getIt<APIClientManager>();

  void _openGallery() async {
    var imagePicker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicker == null) return;
    final imageTemp = File(imagePicker.path);

    setState(() {
      image = imageTemp;
    });

    if (image == null) return;

    String filename = image!.path.split("/").last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(image!.path, filename: filename),
    });

    final response = await _clientAPI.postImageFormData(formData);
    final responseData = response.data;
  }

  void _uploadImage() async {}

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _openGallery,
      child: const Text("Upload Image"),
    );
  }
}
