import 'package:flutter/material.dart';

class ServerNotFound extends StatelessWidget {
  const ServerNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "Cannot load client configuration.\nPlease check the server or server url.",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
