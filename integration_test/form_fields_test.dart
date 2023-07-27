import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:the_tool/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Test form validation", (widgetTester) async {
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

    await widgetTester.pumpAndSettle();
    await widgetTester.enterText(emailField, 'abcd@gmail.com');
    await widgetTester.pumpAndSettle();

    var formEmailField = widgetTester.widget<FormBuilderTextField>(emailField);

    await Future.delayed(const Duration(seconds: 1));

    expect(formEmailField.enabled, true);

    expect(
      formEmailField.decoration.errorText,
      "User already existed !!!",
    );

    var passwordField = find.byType(FormBuilderTextField).last;
    var formPasswordField =
        widgetTester.widget<FormBuilderTextField>(passwordField);

    await widgetTester.enterText(passwordField, '123');
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(
      formPasswordField.decoration.errorText,
      null,
    );

    await widgetTester.enterText(emailField, 'abcd@gmail1.com');
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

    formEmailField = widgetTester.widget<FormBuilderTextField>(emailField);

    await Future.delayed(const Duration(seconds: 1));

    expect(
      formEmailField.decoration.errorText,
      null,
    );

    await widgetTester.enterText(passwordField, '1234');
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    formPasswordField =
        widgetTester.widget<FormBuilderTextField>(passwordField);

    await Future.delayed(const Duration(seconds: 1));

    expect(
      formPasswordField.decoration.errorText,
      "Password is too short !!!",
    );
  });
}
