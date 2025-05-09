import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late TextEditingController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  ///OnTap SendCode
  void _onSendOtp({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final validate = validateForm(_formKey);

    if (!validate) return;

    ref.read(authControllerPr.notifier).forgotPassword(
          context: context,
          email: _emailController.text.trim(),
        );

    return;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerPr);
    return AuthBackground(
      child: AbsorbPointer(
        absorbing: isLoading,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Sizes.spaceHeight),

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
                      "Let’s Help You Get Back In",
                      style: TextStyle(
                        fontSize: Sizes.fontSize18,
                      ),
                    ),
                  ),
                  trailing: FadeAnimations(child: CloseButton()),
                ),

                ///Email
                _EmailField(controller: _emailController),

                ///Send Otp Button
                const SizedBox(height: Sizes.space * 2),
                FadeAnimations(
                  child: CommonButton(
                    onPressed: () => _onSendOtp(
                      context: context,
                      ref: ref,
                    ),
                    text: "Send Otp",
                    isLoading: isLoading,
                  ),
                ),
              ],
            ),
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
        isRequired: true,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          validator: FieldValidators.instance.emailValidator,
          autofillHints: Formatter.instance.emailAutoFillHints,
          decoration: const InputDecoration(hintText: "name@example.com"),
        ),
      ),
    );
  }
}
