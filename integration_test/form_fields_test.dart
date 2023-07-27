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

    // abcd@gmail is invalid email so it will show error
    // "User already existed !!!" is coming from validateFunction in layout code
    await inputEmail(
      widgetTester,
      email: "abcd@gmail.com",
      expectedErrorText: "User already existed !!!",
    );

    // 123 is invalid password but it's not checked yet because email still is invalid
    await inputPassword(
      widgetTester,
      password: "123",
      expectedErrorText: null,
    );

    // abcd@gmail1.com is valid email
    await inputEmail(
      widgetTester,
      email: "abcd@gmail1.com",
      expectedErrorText: null,
    );

    // 1234 is valid password but it's so error because email now is valid
    await inputPassword(
      widgetTester,
      password: "1234",
      expectedErrorText: "Password is too short !!!",
    );
  });
}

Future<void> inputEmail(
  WidgetTester widgetTester, {
  required String email,
  String? expectedErrorText,
}) async {
  var emailField = find.byType(FormBuilderTextField).first;

  await widgetTester.pumpAndSettle();
  await widgetTester.enterText(emailField, email);
  await widgetTester.pumpAndSettle();

  var formEmailField = widgetTester.widget<FormBuilderTextField>(emailField);

  await Future.delayed(const Duration(seconds: 1));

  expect(
    formEmailField.decoration.errorText,
    expectedErrorText,
  );
}

Future<void> inputPassword(
  WidgetTester widgetTester, {
  required String password,
  String? expectedErrorText,
}) async {
  var passwordField = find.byType(FormBuilderTextField).last;

  await widgetTester.enterText(passwordField, password);
  await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

  var formPasswordField =
      widgetTester.widget<FormBuilderTextField>(passwordField);

  await Future.delayed(const Duration(seconds: 1));
  expect(
    formPasswordField.decoration.errorText,
    expectedErrorText,
  );
}
