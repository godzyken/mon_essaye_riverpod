import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/presentation/email_password/utils/email_password_sign_in_form_type.dart';
import 'package:mon_essaye_riverpod/src/utils/async_value_ui.dart';

import '../../../../../common_widgets/action_text_button.dart';
import '../../../../../common_widgets/avatar.dart';
import '../../../../../utils/alert_dialog.dart';
import '../../../data/auth_repository.dart';
import '../../auth/controller/auth_controller.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(authScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));

    final state = ref.watch(authScreenControllerProvider);
    final user = ref.watch(authRepositoryProvider).currentUser;
    return Scaffold(
      appBar: AppBar(
        title: state.isLoading
            ? const CircularProgressIndicator()
            : Text('Account'.hardcoded),
        actions: [
          ActionTextButton(
            text: 'Logout'.hardcoded,
            onPressed: state.isLoading
                ? null
                : () async {
                    final logout = await showAlertDialog(
                      context: context,
                      title: 'Are you sure?'.hardcoded,
                      cancelActionText: 'Cancel'.hardcoded,
                      defaultActionText: 'Logout'.hardcoded,
                    );
                    if (logout == true) {
                      ref.read(authScreenControllerProvider.notifier).signOut();
                    }
                  },
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130.0),
          child: Column(
            children: [
              if (user != null) ...[
                Avatar(
                  photoUrl: user.photoURL,
                  radius: 50,
                  borderColor: Colors.black54,
                  borderWidth: 2.0,
                ),
                const SizedBox(height: 8),
                if (user.displayName != null)
                  Text(
                    user.displayName!,
                    style: const TextStyle(color: Colors.white),
                  ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
