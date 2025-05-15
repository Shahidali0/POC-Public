import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class NotificationIcon extends ConsumerWidget {
  const NotificationIcon({
    super.key,
    this.iconColor,
  });

  final Color? iconColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getNotificationCountFtPr).when(
          data: (count) {
            return badges.Badge(
              position: badges.BadgePosition.topEnd(end: 0.2),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: AppColors.orange,
                shape: badges.BadgeShape.instagram,
              ),
              showBadge: count <= 0 ? false : true,
              badgeContent: Text(
                "$count",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              child: _buildIcon(
                context: context,
                ref: ref,
              ),
            );
          },
          error: (error, st) {
            debugPrint("NotificationError:$error");
            return _buildIcon(
              context: context,
              ref: ref,
            );
          },
          loading: () => const ShowPlatformLoader(),
        );
  }

  ///Notification Icon Buttton
  Widget _buildIcon({
    required BuildContext context,
    required WidgetRef ref,
  }) =>
      CommonIconButton(
        onPressed: () => ref.read(profileControllerPr.notifier).isAuthorized(
              context: context,
              redirectTo: () async => AppRouter.instance.push(
                context: context,
                page: const NotificationScreen(),
              ),
            ),
        iconData: CupertinoIcons.bell,
        iconColor: iconColor,
      );
}
