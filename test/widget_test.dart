// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/data/fake_auth_repository.dart';

import 'user_list_item_test.dart';

void main() {
  testWidgets('override repositoryProvider', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Consumer(
              builder: (context, ref, _) {
                final fakeUsers = ref.watch(todoListProvider);

                if (fakeUsers.asData == null) {
                  return const CircularProgressIndicator();
                }
                return ListView(
                  children: [
                    for (final user in fakeUsers.asData!.value)
                      UserListItem(fakeUser: user)
                  ],
                );
              },
            ),
          ),
        )));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(tester.widgetList(find.byType(UserListItem)), [
      isA<UserListItem>()
          .having((p0) => p0.fakeUser.uid, 'fakeUser.id', '23')
          .having(
              (p0) => p0.fakeUser.email, 'fakeUser.email', 'isgodzy@gmail.com')
          .having((p0) => p0.fakeUser.name, 'fakeUser.name', 'goki')
    ]);
  });
}
