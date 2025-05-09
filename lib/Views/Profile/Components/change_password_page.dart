import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  ///On Change Password
  void _onChangePassword({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final validate = validateForm(_formKey);
    if (!validate) return;

    ref.read(profileControllerPr.notifier).changePassword(
          context: context,
          currentPassword: _currentPasswordController.text.trim(),
          newPassword: _newPasswordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileControllerPr).loading;

    return MyCupertinoSliverScaffold(
      title: "Change Password",
      body: Form(
        key: _formKey,
        child: AbsorbPointer(
          absorbing: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  CupertinoIcons.lock_rotation_open,
                  size: 60,
                ),
              ),

              ///Text
              Text(
                FieldValidators.instance.passwordIncorrectFormat,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              ///Current Password
              _CurrentPasswordField(controller: _currentPasswordController),

              ///NewPassword
              _NewPasswordField(controller: _newPasswordController),

              ///Confirm NewPassword
              _ConfirmNewPasswordField(
                controller: _confirmPasswordController,
                newPsswordController: _newPasswordController,
              ),

              ///SignIn Button
              const SizedBox(height: Sizes.space * 2),
              FadeAnimations(
                child: CommonButton(
                  onPressed: () => _onChangePassword(
                    context: context,
                    ref: ref,
                  ),
                  text: "Change Password",
                  isLoading: isLoading,
                ),
              ),

              const SizedBox(height: Sizes.spaceHeight),
            ],
          ),
        ),
      ),
    );
  }
}

/// Current Password Field
class _CurrentPasswordField extends ConsumerWidget {
  const _CurrentPasswordField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obSecureText = ref.watch(profileControllerPr).obsecureCurrentPassword;

    return FadeAnimations(
      child: FormFiledWidget(
        title: "Current Password",
        child: TextFormField(
          controller: controller,
          obscureText: obSecureText,
          validator: FieldValidators.instance.passwordValidator,
          autofillHints: Formatter.instance.passwordAutoFillHints,
          decoration: InputDecoration(
            hintText: "Enter your current password",
            suffixIcon: GestureDetector(
              onTap: () => ref
                  .read(profileControllerPr.notifier)
                  .updateCurrentPasswordObsecure(!obSecureText),
              child: Icon(
                obSecureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                size: 23,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// New Password Field
class _NewPasswordField extends ConsumerWidget {
  const _NewPasswordField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obSecureText = ref.watch(profileControllerPr).obsecureNewPassword;

    return FadeAnimations(
      child: FormFiledWidget(
        title: "New Password",
        child: TextFormField(
          controller: controller,
          obscureText: obSecureText,
          validator: FieldValidators.instance.passwordValidator,
          autofillHints: Formatter.instance.passwordAutoFillHints,
          decoration: InputDecoration(
            hintText: "Enter your new password",
            suffixIcon: GestureDetector(
              onTap: () => ref
                  .read(profileControllerPr.notifier)
                  .updateNewPasswordObsecure(!obSecureText),
              child: Icon(
                obSecureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                size: 23,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Confirm New Password Field
class _ConfirmNewPasswordField extends ConsumerWidget {
  const _ConfirmNewPasswordField({
    required this.controller,
    required this.newPsswordController,
  });

  final TextEditingController controller;
  final TextEditingController newPsswordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obSecureText = ref.watch(profileControllerPr).obsecureConfirmPassword;

    return FadeAnimations(
      child: FormFiledWidget(
        title: "Confirm Password",
        child: TextFormField(
          controller: controller,
          obscureText: obSecureText,
          validator: (value) =>
              FieldValidators.instance.confirmPasswordValidator(
            value: value,
            newPassword: newPsswordController.text.trim(),
          ),
          autofillHints: Formatter.instance.passwordAutoFillHints,
          decoration: InputDecoration(
            hintText: "Confirm your password",
            suffixIcon: GestureDetector(
              onTap: () => ref
                  .read(profileControllerPr.notifier)
                  .updateConfirmPasswordObsecure(!obSecureText),
              child: Icon(
                obSecureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                size: 23,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
