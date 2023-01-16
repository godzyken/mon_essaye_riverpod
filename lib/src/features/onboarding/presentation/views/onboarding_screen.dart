import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/common_widgets/primary_button.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/presentation/email_password/utils/email_password_sign_in_form_type.dart';
import 'package:mon_essaye_riverpod/src/routing/app_router.dart';

import '../../../../utils/images_assets.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Track your time.\n Because time counts.',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: SvgPicture.asset(
                ImagesAssets.timeTrackingSvg,
                semanticsLabel: 'Time tracking logo',
              ),
            ),
            PrimaryButton(
              text: 'Get Started'.hardcoded,
              isLoading: state.isLoading,
              onPressed: state.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(onboardingControllerProvider.notifier)
                          .completeOnboarding();

                      context.goNamed(AppRoute.signIn.name);
                    },
            )
          ],
        ),
      ),
    );
  }
}
