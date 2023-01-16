import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/utils/async_value_ui.dart';

import '../../../../../common_widgets/custom_text_button.dart';
import '../../../../../common_widgets/primary_button.dart';
import '../../../../../common_widgets/responsible_scrollable_card.dart';
import '../../../../../constants/app_size.dart';
import '../controller/email_password_sign_in_controller.dart';
import '../utils/email_password_sign_in_form_type.dart';
import '../utils/email_password_validators.dart';
import '../utils/string_validators.dart';

class EmailPasswordSignInScreen extends StatelessWidget {
  const EmailPasswordSignInScreen({super.key, required this.formType});
  final EmailPasswordSignInFormType formType;

  static const emailKey = Key('email');
  static const passwordKey = Key('password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'.hardcoded),
      ),
      body: EmailPasswordSignInContents(formType: formType),
    );
  }
}

class EmailPasswordSignInContents extends ConsumerStatefulWidget {
  const EmailPasswordSignInContents({super.key, required this.formType});
  final EmailPasswordSignInFormType formType;

  @override
  ConsumerState<EmailPasswordSignInContents> createState() =>
      _EmailPasswordSignInContentsState();
}

class _EmailPasswordSignInContentsState
    extends ConsumerState<EmailPasswordSignInContents>
    with EmailAndPasswordValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;

  var _submitted = false;
  late var _formType = widget.formType;

  @override
  void dispose() {
    _emailController.dispose();
    _node.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(emailPasswordSignInControllerProvider.notifier);
      await controller.submit(
          email: email, password: password, formType: _formType);
    }
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  void _updateFormType() {
    setState(() {
      _formType = _formType.secondaryActionFormType;
    });
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(emailPasswordSignInControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(emailPasswordSignInControllerProvider);
    return ResponsiveScrollableCard(
      child: FocusScope(
        node: _node,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              gapH8,
              // Email field
              TextFormField(
                key: EmailPasswordSignInScreen.emailKey,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email'.hardcoded,
                  hintText: 'test@test.com'.hardcoded,
                  enabled: !state.isLoading,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    !_submitted ? null : emailErrorText(email ?? ''),
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _emailEditingComplete(),
                inputFormatters: <TextInputFormatter>[
                  ValidatorInputFormatter(
                      editingValidator: EmailEditingRegexValidator()),
                ],
              ),
              gapH8,
              // Password field
              TextFormField(
                key: EmailPasswordSignInScreen.passwordKey,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: _formType.passwordLabelText,
                  enabled: !state.isLoading,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => !_submitted
                    ? null
                    : passwordErrorText(password ?? '', _formType),
                obscureText: true,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _passwordEditingComplete(),
              ),
              gapH8,
              PrimaryButton(
                text: _formType.primaryButtonText,
                isLoading: state.isLoading,
                onPressed: state.isLoading ? null : () => _submit(),
              ),
              gapH8,
              CustomTextButton(
                text: _formType.secondaryButtonText,
                onPressed: state.isLoading ? null : _updateFormType,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
