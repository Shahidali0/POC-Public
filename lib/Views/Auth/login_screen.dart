import 'dart:async';
import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'Controller/auth_controller.dart';
part 'package:cricket_poc/Views/Auth/sign_up_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  ///OnTap SignIn
  void _onTapSignIn({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    Utils.instance.hideFoucs(context);
    await ref.read(authControllerPr.notifier).signInUser(
          context: context,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
    return;
  }

  ///OnTap Forgot Password
  void _onForgotPassword({
    required BuildContext context,
  }) async {
    return AppRouter.instance.push(
      context: context,
      page: const ForgotPasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerPr);

    return AuthBackground(
      child: AbsorbPointer(
        absorbing: isLoading,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Sizes.spaceHeight),

              ///Logo
              ///Header
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: FadeAnimations(
                  child: Text(
                    "👋 Hello,",
                    style: TextStyle(
                      fontSize: Sizes.fontSize24,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                subtitle: FadeAnimations(
                  child: Text(
                    "Let's get you back in the game!",
                    style: TextStyle(
                      fontSize: Sizes.fontSize18,
                    ),
                  ),
                ),
                trailing: FadeAnimations(child: CloseButton()),
              ),

              ///Email
              _EmailField(controller: _emailController),

              ///Password
              _PasswordField(controller: _passwordController),

              ///Forgot Password
              FadeAnimations(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CommonTextButton(
                    onPressed: () => _onForgotPassword(context: context),
                    text: "Forgot Password?",
                  ),
                ),
              ),

              ///SignIn Button
              const SizedBox(height: Sizes.space * 1.5),
              FadeAnimations(
                child: CommonButton(
                  onPressed: () => _onTapSignIn(
                    context: context,
                    ref: ref,
                  ),
                  text: "Sign In",
                  isLoading: isLoading,
                ),
              ),

              ///Have an account
              const SizedBox(height: Sizes.spaceHeight),
              const HaveAnAccountWidget(authType: AuthType.login),
            ],
          ),
        ),
      ),
    );
  }
}

///Email Field
class _EmailField extends StatelessWidget {
  const _EmailField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FadeAnimations(
      child: FormFiledWidget(
        title: "Email",
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          autofillHints: Formatter.instance.emailAutoFillHints,
          decoration: const InputDecoration(hintText: "Enter your email"),
        ),
      ),
    );
  }
}

///Password Field
class _PasswordField extends ConsumerWidget {
  const _PasswordField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obSecureText = ref.watch(_obSecurePasswordPr);

    return FadeAnimations(
      child: FormFiledWidget(
        title: "Password",
        child: TextFormField(
          controller: controller,
          obscureText: obSecureText,
          autofillHints: Formatter.instance.passwordAutoFillHints,
          decoration: InputDecoration(
            hintText: "Enter your password",
            suffixIcon: GestureDetector(
              onTap: () => ref
                  .read(_obSecurePasswordPr.notifier)
                  .update((state) => state = !obSecureText),
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
