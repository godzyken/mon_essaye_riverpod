import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/auth_repository.dart';

class AuthController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final database = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => database.signOut());
  }
}

final authScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<AuthController, void>(AuthController.new);
