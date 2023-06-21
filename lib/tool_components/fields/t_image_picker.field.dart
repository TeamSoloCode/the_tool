import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class TImagePickerField extends TWidget {
  TImagePickerField(TWidgetProps twidget) : super(twidget);

  @override
  State<TImagePickerField> createState() => _TImagePickerFieldState();
}

class _TImagePickerFieldState extends State<TImagePickerField> {
  File? image;

  void _imagePicker() async {
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

    Dio dio = Dio();

    dio.post("endpoint", data: formData).then((response) {
      var jsonResponse = jsonDecode(response.toString());
      var testData = jsonResponse['histogram_counts'].cast<double>();
      var averageGrindSize = jsonResponse['average_particle_size'];
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
