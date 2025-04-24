import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Cupertino Appbar
///[ObstructingPreferredSizeWidget] is used to make the appbar
class CupertinoAppbar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const CupertinoAppbar({
    super.key,
    required this.title,
    this.previousPageTitle,
    this.trailing,
    this.showNotificationIcon = false,
  });

  final String title;
  final String? previousPageTitle;
  final Widget? trailing;

  final bool showNotificationIcon;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      transitionBetweenRoutes: false,
      backgroundColor: AppColors.transparent,
      border: const Border(
        bottom: BorderSide(color: AppColors.blueGrey, width: 0.1),
      ),
      previousPageTitle: previousPageTitle ?? "Back",
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) trailing!,
          if (showNotificationIcon)
            CommonIconButton(
              onPressed: () => AppRouter.instance.push(
                context: context,
                page: const NotificationScreen(),
              ),
              iconData: CupertinoIcons.bell,
            ),
        ],
      ),
      middle: Text(
        title,
        style: const TextStyle(
          color: AppColors.appTheme,
          fontSize: Sizes.fontSize18,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  bool shouldFullyObstruct(BuildContext context) => false;
}
