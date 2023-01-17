import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/fake_auth_repository.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncData(null));
  final FakeAuthRepository authRepository;

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(authRepository.signOut);
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  return AccountScreenController(
    authRepository: ref.watch(authRepositoryProvider),
  );
});
