import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:the_tool/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('e2e', () {
    testWidgets("login page", (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 1));

      // Loading page
      await widgetTester.pumpAndSettle(
        const Duration(milliseconds: 500),
      );

      // Login page
      await widgetTester.pumpAndSettle(
        const Duration(milliseconds: 500),
      );

      await Future.delayed(const Duration(seconds: 1));

      var emailField = find.byType(FormBuilderTextField).first;
      var passwordField = find.byType(FormBuilderTextField).last;

      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(emailField, 'abcd@gmail.com');
      await widgetTester.pumpAndSettle();

      final FormBuilderTextField formfield =
          widgetTester.widget<FormBuilderTextField>(emailField);

      await Future.delayed(const Duration(seconds: 1));

      expect(formfield.enabled, true);

      expect(
        formfield.decoration.errorText,
        "User already existed !!!",
        reason:
            "In JS if type in 'abcd@gmail.com' then errorText should be 'User already existed !!!'",
      );

      await widgetTester.enterText(emailField, 'abcd@gmail1.com');
      await widgetTester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 1));

      expect(
        formfield.decoration.errorText,
        null,
        reason:
            "In JS if type in 'abcd@gmail1.com' then errorText should be null",
      );
    });
  });
}
