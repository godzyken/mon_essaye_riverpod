import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/features/onboarding/data/onboarding_repository.dart';

class OnboardingController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> completeOnboarding() async {
    final onboardingRepository = ref.watch(onboardingRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(onboardingRepository.setOnBoardingComplete);
  }
}

final onboardingControllerProvider =
    AutoDisposeAsyncNotifierProvider<OnboardingController, void>(
        OnboardingController.new);
