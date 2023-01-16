import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/data/auth_repository.dart';

class SignInScreenController extends AutoDisposeAsyncNotifier<void> {
  Future<void> signInAnonymously() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInAnonymously);
  }

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}

final signInScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignInScreenController, void>(
        SignInScreenController.new);
