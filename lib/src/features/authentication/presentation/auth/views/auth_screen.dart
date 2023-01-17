import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/data/auth_repository.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/presentation/account/views/account_screen.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/presentation/sign_in/views/sign_in_screen.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authStateChangesProvider);

    return state.maybeWhen(
        data: (user) =>
            user != null ? const AccountScreen() : const SignInScreen(),
        orElse: () => Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}
