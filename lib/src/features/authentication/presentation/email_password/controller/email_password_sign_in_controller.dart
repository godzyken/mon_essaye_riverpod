import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/data/auth_repository.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/presentation/email_password/utils/email_password_sign_in_form_type.dart';

class EmailPasswordSignInController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> submit({
    required String email,
    required String password,
    required EmailPasswordSignInFormType formType,
  }) async {
    state = const AsyncValue.loading();
    state =
        await AsyncValue.guard(() => _authenticate(email, password, formType));
  }

  Future<void> _authenticate(
      String email, String password, EmailPasswordSignInFormType formType) {
    final authRepository = ref.read(authRepositoryProvider);
    switch (formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return authRepository.createUserWithEmailAndPassword(email, password);
    }
  }
}

final emailPasswordSignInControllerProvider =
    AutoDisposeAsyncNotifierProvider<EmailPasswordSignInController, void>(
        EmailPasswordSignInController.new);
