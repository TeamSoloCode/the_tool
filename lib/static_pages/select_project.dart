import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/utils.dart';

class SelectProjectPage extends StatefulWidget {
  final void Function(String projectName) loadProject;

  const SelectProjectPage({
    Key? key,
    required this.loadProject,
  }) : super(key: key);

  @override
  State<SelectProjectPage> createState() => _SelectProjectPageState();
}

class _SelectProjectPageState extends State<SelectProjectPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _storageManager = getIt<StorageManager>();
  void _onSubmit() {
    var formFields = _formKey.currentState?.fields ?? {};

    var projectName = formFields["projectName"];
    var remember = formFields["remember"];

    _storageManager.setLocalBox("projectName", projectName?.value);
    _storageManager.setLocalBox("remember", remember?.value);

    if (projectName?.value != null) {
      widget.loadProject(projectName?.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilderTextField(
                    name: "projectName",
                    initialValue: _storageManager.getLocalBox("projectName"),
                    decoration: const InputDecoration(
                      labelText: "Project name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderCheckbox(
                          name: "remember",
                          initialValue: _storageManager.getLocalBox("remember"),
                          title: const Text("Remember"),
                          selected: true,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            child: const Text("Submit"),
                            onPressed: _onSubmit,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
