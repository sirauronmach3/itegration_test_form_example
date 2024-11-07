import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:itegration_test_form_example/home_screen.dart';
import 'package:itegration_test_form_example/login_screen.dart';
import 'package:itegration_test_form_example/main.dart' as app;

void main() {
  group(
    'end to end test',
    () {
      testWidgets(
        'verify login screen with correct username and password',
        (tester) async {
          app.main();
          await tester.pumpAndSettle();

          final String correctUsername = 'username';
          final String correctPassword = 'password';

          final Finder usernameEntryField = find.byKey(Key('username entry'));
          final Finder passwordEntryField = find.byKey(Key('password entry'));
          final Finder loginBtn = find.byType(ElevatedButton);

          await tester.enterText(usernameEntryField, correctUsername);
          await tester.enterText(passwordEntryField, correctPassword);
          await tester.tap(loginBtn);

          await tester.pumpAndSettle();

          expect(find.byType(HomeScreen), findsOneWidget);
        },
      );

      testWidgets(
        'verify login screen with incorrect username and password',
        (tester) async {
          app.main();
          await tester.pumpAndSettle();

          final String incorrectUsername = 'matthew';
          final String incorrectPassword = '1234';

          final Finder usernameEntryField = find.byKey(Key('username entry'));
          final Finder passwordEntryField = find.byKey(Key('password entry'));
          final Finder loginBtn = find.byType(ElevatedButton);

          await tester.enterText(usernameEntryField, incorrectUsername);
          await tester.enterText(passwordEntryField, incorrectPassword);
          await tester.tap(loginBtn);

          await tester.pumpAndSettle();

          expect(find.byType(AlertDialog), findsOneWidget);
          expect(find.text('Invalid username or password'), findsOne);
          expect(find.byType(LoginPage), findsOneWidget);
        },
      );
    },
  );
}
