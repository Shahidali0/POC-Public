import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  ///OnTap SendCode
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
                    "Welcome back to your account",
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

              ///SignIn Button
              const SizedBox(height: Sizes.space * 2),
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
    final obSecureText = ref.watch(obSecurePasswordPr);

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
                  .read(obSecurePasswordPr.notifier)
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
