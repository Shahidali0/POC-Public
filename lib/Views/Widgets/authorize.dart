import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class AuthorizedWidget extends ConsumerWidget {
  const AuthorizedWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(isAuthroizedPr).when(
          data: (isAuthorized) {
            ///If User is not authorized then show Authorize Widget
            if (!isAuthorized) {
              return const _LoginWidget();
            }

            /// If User is authorized then show User Profile
            return child;
          },
          error: (error, stackTrace) => ErrorText(
            title: AppExceptions.instance.serverError,
            error: AppExceptions.instance.normalErrorText,
            onRefresh: () => ref.refresh(isAuthroizedPr),
          ),
          loading: () => Padding(
            padding: Sizes.globalPadding * 3,
            child: const ShowPlatformLoader(),
          ),
        );
  }
}

///Login Widget
class _LoginWidget extends StatelessWidget {
  const _LoginWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: Sizes.spaceHeight),
          Text(
            "ACCOUNT",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppTheme.boldFont,
                ),
          ),
          Text(
            "Login/Create Account to manage services",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: Sizes.space),
          CommonButton(
            onPressed: () => AppRouter.instance.push(
              context: context,
              screen: const LoginScreen(),
            ),
            text: "Login",
          ),
          const SizedBox(height: Sizes.spaceHeight),
        ],
      ),
    );
  }
}
