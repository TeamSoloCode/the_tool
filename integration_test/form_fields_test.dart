import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:the_tool/main.dart' as app;
import 'package:the_tool/tool_components/datatable/t_datatable_widget.dart';

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
    await widgetTester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 1));

    // await widgetTester.pumpAndSettle();
    await pressLoginButton(widgetTester);
    await widgetTester.pumpAndSettle((const Duration(milliseconds: 500)));

    /**
     * When login page just show up and the login button is pressed
     * then user cannot go to the dashboard page
     * so the email field must be still there
     */
    expect(find.byType(FormBuilderTextField).first, findsOneWidget);

    await inputEmail(
      widgetTester,
      email: "abcd",
      expectedErrorText: "Username must be an email address.",
      errorFromDartValidator: true,
    );

    await inputEmail(
      widgetTester,
      email: "",
      expectedErrorText: "Username cannot be empty.",
      errorFromDartValidator: true,
    );

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

    // FIXME: This should not go to the dashboard page because password is invalid
    await pressLoginButton(widgetTester);
    await widgetTester.pumpAndSettle((const Duration(seconds: 1)));

    /**
     * At this step, the email is valid but password is invalid
     * so the email field must be still there
     */
    expect(find.byType(FormBuilderTextField).first, findsOneWidget);

    // "" is invalid password so it will show error This field cannot be empty
    await inputPassword(
      widgetTester,
      password: "",
      expectedErrorText: "Password cannot be empty.",
    );

    // 1234 is valid password but it's so error because email now is valid
    await inputPassword(
      widgetTester,
      password: "1234",
      expectedErrorText: "Password is too short !!!",
    );

    // 123456 is valid password
    await inputPassword(
      widgetTester,
      password: "123456",
      expectedErrorText: null,
    );

    await pressLoginButton(widgetTester);
    await loginSuccess(widgetTester);
  });
}

Future<void> inputEmail(
  WidgetTester widgetTester, {
  required String email,
  String? expectedErrorText,
  bool errorFromDartValidator = false,
}) async {
  var emailField = find.byType(FormBuilderTextField).first;

  await widgetTester.pumpAndSettle();
  await widgetTester.enterText(emailField, email);
  await widgetTester.pumpAndSettle();

  var formEmailField = widgetTester.widget<FormBuilderTextField>(emailField);

  await Future.delayed(const Duration(seconds: 1));
  if (errorFromDartValidator) {
    expect(
      formEmailField.validator?.call(email),
      expectedErrorText,
    );
  } else {
    expect(
      formEmailField.decoration.errorText,
      expectedErrorText,
    );
  }
}

Future<void> inputPassword(
  WidgetTester widgetTester, {
  required String password,
  String? expectedErrorText,
  bool errorFromDartValidator = false,
}) async {
  await widgetTester.pumpAndSettle();

  var passwordField = find.byType(FormBuilderTextField).last;

  await widgetTester.enterText(passwordField, password);
  await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

  var formPasswordField =
      widgetTester.widget<FormBuilderTextField>(passwordField);

  await Future.delayed(const Duration(seconds: 1));
  if (errorFromDartValidator) {
    expect(
      formPasswordField.validator?.call(password),
      expectedErrorText,
    );
  } else {
    expect(
      formPasswordField.decoration.errorText,
      expectedErrorText,
    );
  }
}

Future<void> pressLoginButton(WidgetTester widgetTester) async {
  await widgetTester.pumpAndSettle();

  var loginButton = find.byType(ElevatedButton).first;

  await widgetTester.tap(loginButton);
  await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

  await Future.delayed(const Duration(seconds: 1));

  // var userTable = find.byType(TDataTable).first;

  // expect(userTable, findsOneWidget);
}

Future<void> loginSuccess(WidgetTester widgetTester) async {
  await widgetTester.pumpAndSettle();
  var userTable = find.byType(TDataTable).first;
  expect(userTable, findsOneWidget);
}
