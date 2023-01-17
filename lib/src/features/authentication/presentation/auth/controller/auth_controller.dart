import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/services/auth_service.dart';

import '../../../data/auth_repository.dart';

class AuthController extends AutoDisposeAsyncNotifier<void> {
  Duration get timeLimit => const Duration(hours: 3);

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> connectToDatabase() async {
    final database = ref.read(authServiceProvider).useAuthEmulator();

    database.timeout(timeLimit);
    database.whenComplete(() => state.isRefreshing);
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
