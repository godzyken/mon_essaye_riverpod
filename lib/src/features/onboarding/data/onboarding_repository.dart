import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingRepository {
  OnBoardingRepository(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  static const onboardingCompleteKey = 'onboardingComplete';

  Future<void> setOnBoardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  bool isOnboardingComplete() =>
      sharedPreferences.getBool(onboardingCompleteKey) ?? false;
}

final onboardingRepositoryProvider = Provider<OnBoardingRepository>((ref) {
  throw UnimplementedError();
});
