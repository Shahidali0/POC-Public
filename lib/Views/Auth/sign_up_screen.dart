import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _homeSuburbController;
  late TextEditingController _abnController;

  final ValueNotifier<String?> _selectedGoal = ValueNotifier(null);
  final ValueNotifier<String?> _aboutYourSelf = ValueNotifier(null);
  final ValueNotifier<bool> _hidePassword = ValueNotifier(true);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _homeSuburbController = TextEditingController();
    _abnController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _homeSuburbController.dispose();
    _abnController.dispose();
    _selectedGoal.dispose();
    _aboutYourSelf.dispose();

    super.dispose();
  }

  ///Update Selected Goal value
  void _updateSelectedGoal(String value) => _selectedGoal.value = value;

  ///Update About Youself  value
  void _updateAboutYourSelf(String value) => _aboutYourSelf.value = value;

  ///Hide Password
  void hidePasswordFunction() {
    _hidePassword.value = !_hidePassword.value;
  }

  ///OnTap SignUp
  void _onTapSignUp({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    Utils.instance.hideFoucs(context);
    final signUpDto = SignUpDto(
      username: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      suburb: _homeSuburbController.text.trim(),
      goal: _selectedGoal.value,
      userType: _aboutYourSelf.value,
      abn: _abnController.text.trim(),
      createdDate: DateTime.now(),
    );

    await ref.read(authControllerPr.notifier).signUpUser(
          context: context,
          signUpDto: signUpDto,
          formKey: _formKey,
        );
    return;
  }

  @override
  Widget build(BuildContext context) {
    final mainGoalErrorText = ref.watch(signupGoalErrorPr);
    final aboutYourSelfErrorText = ref.watch(signupAbouYouSelfErrorPr);

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
                      "Get started with SportZReady",
                      style: TextStyle(
                        fontSize: Sizes.fontSize18,
                      ),
                    ),
                  ),
                  trailing: FadeAnimations(child: CloseButton()),
                ),

                ///FirstName And LastName
                _FullNameField(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                ),

                ///Email
                _EmailField(controller: _emailController),

                ///New Password
                _NewPasswordField(
                  controller: _passwordController,
                  hidePassword: _hidePassword,
                  hidePasswordFunction: hidePasswordFunction,
                ),

                ///HomeSubhurb
                _HomeSuburbField(controller: _homeSuburbController),

                ///MainGoal
                _MainGoalWidget(
                  slectedGoal: _selectedGoal,
                  updateData: _updateSelectedGoal,
                ),
                if (mainGoalErrorText.isNotEmpty)
                  ValidationErrorText(text: mainGoalErrorText),

                ///About Yourself
                _AboutYourSelfWidget(
                  aboutYourSelf: _aboutYourSelf,
                  updateData: _updateAboutYourSelf,
                ),
                if (aboutYourSelfErrorText.isNotEmpty)
                  ValidationErrorText(text: aboutYourSelfErrorText),

                ///ABN
                _ABNField(controller: _abnController),

                ///SignUp Button
                const SizedBox(height: Sizes.space * 2),
                FadeAnimations(
                  child: CommonButton(
                    onPressed: () => _onTapSignUp(
                      context: context,
                      ref: ref,
                    ),
                    text: "Sign Up",
                    isLoading: isLoading,
                  ),
                ),

                ///Have an account
                const SizedBox(height: Sizes.spaceHeight),
                const HaveAnAccountWidget(authType: AuthType.signup),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///FullName Field
class _FullNameField extends StatelessWidget {
  const _FullNameField({
    required this.firstNameController,
    required this.lastNameController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///First Name
          Flexible(
            child: FadeAnimations(
              child: FormFiledWidget(
                title: "First Name",
                isRequired: true,
                child: TextFormField(
                  controller: firstNameController,
                  keyboardType: TextInputType.name,
                  validator: FieldValidators.instance.commonValidator,
                  autofillHints: Formatter.instance.firstNameAutoFillHints,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(hintText: "John"),
                ),
              ),
            ),
          ),

          ///Last Name
          Flexible(
            child: FadeAnimations(
              child: FormFiledWidget(
                title: "Last Name",
                isRequired: true,
                child: TextFormField(
                  controller: lastNameController,
                  keyboardType: TextInputType.name,
                  validator: FieldValidators.instance.commonValidator,
                  autofillHints: Formatter.instance.lastNameAutoFillHints,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(hintText: "Doe"),
                ),
              ),
            ),
          ),
        ],
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

///New Password Field
class _NewPasswordField extends StatelessWidget {
  const _NewPasswordField({
    required this.controller,
    required this.hidePassword,
    required this.hidePasswordFunction,
  });

  final TextEditingController controller;
  final ValueNotifier hidePassword;
  final VoidCallback? hidePasswordFunction;

  @override
  Widget build(BuildContext context) {
    return FadeAnimations(
      child: FormFiledWidget(
        title: "Password",
        isRequired: true,
        child: ValueListenableBuilder(
          valueListenable: hidePassword,
          builder: (BuildContext context, value, Widget? child) {
            return TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              obscureText: value,
              validator: FieldValidators.instance.passwordValidator,
              decoration: InputDecoration(
                hintText: "Enter a new password",
                suffixIcon: IconButton(
                  onPressed: hidePasswordFunction,
                  icon: Icon(
                    value
                        ? CupertinoIcons.eye_slash_fill
                        : CupertinoIcons.eye_fill,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

///HomeSuburb Field
class _HomeSuburbField extends StatelessWidget {
  const _HomeSuburbField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FadeAnimations(
      child: FormFiledWidget(
        title: "Enter your home suburb",
        isRequired: true,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.name,
          validator: FieldValidators.instance.commonValidator,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(hintText: "Enter a suburb"),
        ),
      ),
    );
  }
}

///What is your main goal on PlayMate?
class _MainGoalWidget extends StatelessWidget {
  const _MainGoalWidget({
    required this.slectedGoal,
    required this.updateData,
  });

  final ValueNotifier<String?> slectedGoal;
  final Function(String value) updateData;

  @override
  Widget build(BuildContext context) {
    return FadeAnimations(
      child: FormFiledWidget(
        title: "What is your main goal on PlayMate?",
        isRequired: true,
        child: SizedBox(
          width: double.infinity,
          child: ValueListenableBuilder(
            valueListenable: slectedGoal,
            builder: (BuildContext context, String? goal, Widget? child) {
              return CupertinoSlidingSegmentedControl<String?>(
                groupValue: goal,
                thumbColor: AppColors.appTheme,
                children: <String?, Widget>{
                  ///Get Things Done
                  "Done": _CardWidgetForSegments(
                    iconData: CupertinoIcons.check_mark_circled,
                    text: "Get Things Done",
                    color: goal != null && goal == "Done"
                        ? AppColors.white
                        : AppColors.blueGrey,
                  ),

                  ///Earn Money
                  "Money": _CardWidgetForSegments(
                    iconData: CupertinoIcons.money_dollar,
                    text: "Earn Money",
                    color: goal != null && goal == "Money"
                        ? AppColors.white
                        : AppColors.blueGrey,
                  ),
                },
                onValueChanged: (String? value) {
                  if (value == null) return;

                  updateData(value);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

///Tell us about yourself
class _AboutYourSelfWidget extends StatelessWidget {
  const _AboutYourSelfWidget({
    required this.aboutYourSelf,
    required this.updateData,
  });

  final ValueNotifier<String?> aboutYourSelf;
  final Function(String value) updateData;

  @override
  Widget build(BuildContext context) {
    return FadeAnimations(
      child: FormFiledWidget(
        title: "Tell us about yourself",
        isRequired: true,
        child: SizedBox(
          width: double.infinity,
          child: ValueListenableBuilder(
            valueListenable: aboutYourSelf,
            builder: (BuildContext context, String? aboutYou, Widget? child) {
              return CupertinoSlidingSegmentedControl<String?>(
                groupValue: aboutYou,
                thumbColor: AppColors.appTheme,
                children: <String?, Widget>{
                  ///Individual
                  "Individual": _CardWidgetForSegments(
                    iconData: CupertinoIcons.person,
                    text: "Individual",
                    color: aboutYou != null && aboutYou == "Individual"
                        ? AppColors.white
                        : AppColors.blueGrey,
                  ),

                  ///Business user
                  "Business": _CardWidgetForSegments(
                    iconData: CupertinoIcons.building_2_fill,
                    text: "Business User",
                    color: aboutYou != null && aboutYou == "Business"
                        ? AppColors.white
                        : AppColors.blueGrey,
                  ),
                },
                onValueChanged: (String? value) {
                  if (value == null) return;

                  updateData(value);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

///ABN Field
class _ABNField extends StatelessWidget {
  const _ABNField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FadeAnimations(
      child: FormFiledWidget(
        title: "ABN (if applicable)",
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.name,
          textCapitalization:
              TextCapitalization.characters, // Capitalizes each letter
          onChanged: (text) {
            controller.value = controller.value.copyWith(
              text: text.toUpperCase(),
              selection: TextSelection.collapsed(offset: text.length),
            );
          },
          decoration: const InputDecoration(hintText: "Enter a suburb"),
        ),
      ),
    );
  }
}

///Card Widget for Segments
class _CardWidgetForSegments extends StatelessWidget {
  const _CardWidgetForSegments({
    required this.iconData,
    required this.text,
    required this.color,
  });

  final IconData iconData;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.spaceHeight * 1.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: color,
          ),
          const SizedBox(height: Sizes.spaceMed),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}


///
// ///Selection Widget
// class _SelectionWidget extends StatelessWidget {
//   const _SelectionWidget({super.key});

//   final IconData icon1;
//   final IconData icon2;
//   final String text1;
//   final String text2;
//   final Function

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ///Card1
//           Expanded(
//             child: showCardData(
//               iconData: Icons.done_all_rounded,
//               text: "SHSHSHS",
//               isSelected: false,
//             ),
//           ),
//           const SizedBox(width: Sizes.space),

//           ///Card2
//           Expanded(
//             child: showCardData(
//               iconData: Icons.done_all_rounded,
//               text: "SHSHSHS",
//               isSelected: false,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   ///Widget for showing animation
//   Widget showAnimation({bool animate = true}) => AnimatedPositioned(
//         duration: Sizes.durationS,
//         height: double.maxFinite,
//         width: animate ? 200 : 0,
//         child: Container(
//           decoration: const BoxDecoration(
//             color: AppColors.appTheme,
//             // borderRadius: BorderRadius.circular(Sizes.borderRadius),
//           ),
//         ),
//       );

//   ///Widget for showing card data
//   Widget showCardData({
//     required IconData iconData,
//     required String text,
//     required bool isSelected,
//   }) =>
//       GestureDetector(
//         onTap: () {},
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(Sizes.borderRadius),
//           child: Card(
//             margin: EdgeInsets.zero,
//             color: AppColors.white,
//             child: Stack(
//               children: [
//                 ///If Selected Show Animation
//                 showAnimation(animate: false),

//                 ///Card
//                 SizedBox.expand(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         iconData,
//                         color:
//                             isSelected ? AppColors.white : AppColors.blueGrey,
//                       ),
//                       Text(
//                         text,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           color:
//                               isSelected ? AppColors.white : AppColors.blueGrey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
// }
