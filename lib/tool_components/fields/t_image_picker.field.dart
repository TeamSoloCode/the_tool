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
  Widget? pickedImage;

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
      pickedImage = image;
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

    Map<String, dynamic> options = {};

    if (widget.widgetProps.host != null) {
      options["host"] = widget.widgetProps.host;
      if (options["host"] is! String) {
        throw Exception("\"host\" property of image field should be a string");
      }
    }

    final response = await _clientAPI.postImageFormData(
      formData,
      options: options,
    );

    final onResponse = widget.widgetProps.onChange;
    if (onResponse != null) {
      final responseData = response.data;
      widget.executeJSWithPagePath(onResponse, [responseData]);
    }
  }

  void _clearImage() {
    final onChange = widget.widgetProps.onChange;
    if (onChange != null) {
      setState(() {
        image = null;
        pickedImage = null;
      });
      widget.executeJSWithPagePath(onChange, [null]);
    }
  }

  Widget _defaultPlaceholder(LayoutProps props) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Center(
              child: pickedImage ??
                  Row(
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
            ),
          ),
        ),
        _actionButton(props),
      ],
    );
  }

  Widget _actionButton(LayoutProps props) {
    Widget content = Positioned(
      top: 0,
      right: 0,
      child: GestureDetector(
        onTap: _clearImage,
        child: Container(
          // padding: EdgeInsets.all(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: const Icon(
            Icons.clear,
          ),
        ),
      ),
    );

    return content;
  }

  Widget _computeImageChild(LayoutProps props) {
    Widget pickedImage = image ?? const Offstage();
    List<Widget> content = [
      _defaultPlaceholder(props),
      pickedImage,
    ];

    if (props.child != null) {
      content = [
        TWidgets(
          layout: props.child!,
          pagePath: widget.pagePath,
          childData: widget.childData,
        ),
        pickedImage
      ];
    }

    return Stack(
      alignment: Alignment.center,
      children: content,
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? props = widget.props;

    if (props != null) {
      snapshot = GestureDetector(
        onTap: _openGallery,
        child: _computeImageChild(props),
      );
    }

    return snapshot;
  }
}
