import 'package:flutter/material.dart';

class DefaultNotFoundPage extends StatelessWidget {
  const DefaultNotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          "ERROR 404: Page Not Found",
          style: theme.textTheme.displayMedium,
        ),
      ),
    );
  }
}
