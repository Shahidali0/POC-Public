import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceOffersPage extends StatelessWidget {
  const ServiceOffersPage({
    super.key,
    required this.serviceJson,
    this.showButtons = false,
  });

  final ServiceJson serviceJson;
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const PageStorageKey('ServiceOffersPage'),
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return _MyRequests(
          serviceJson: serviceJson,
          showButtons: showButtons,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: Sizes.space),
    );
  }
}

///Request List
class _MyRequests extends ConsumerWidget {
  const _MyRequests({
    required this.serviceJson,
    required this.showButtons,
  });

  final ServiceJson serviceJson;
  final bool showButtons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: Sizes.globalMargin,
      child: Padding(
        padding: Sizes.globalPadding,
        child: Column(
          children: [
            CupertinoListTile.notched(
              padding: EdgeInsets.zero,
              title: Text(
                serviceJson.title!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: Sizes.fontSize18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "${serviceJson.category} (${serviceJson.sport})",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.orange,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ///Reject
                  CommonCircleButton(
                    iconData: CupertinoIcons.clear,
                    onPressed: () {},
                  ),
                  const SizedBox(width: Sizes.space),

                  ///Accept
                  CommonCircleButton(
                    color: AppColors.green,
                    iconData: CupertinoIcons.check_mark,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            ///Date
            CustomListTile(
              iconData: CupertinoIcons.calendar,
              text: serviceJson.timeSlots!.entries.first.key,
            ),

            ///Duration
            CustomListTile(
              iconData: CupertinoIcons.time,
              text: Utils.instance.getDuration(serviceJson.duration),
            ),
            if (!showButtons) const SizedBox(height: Sizes.space),

            // ///Buttons
            // if (showButtons)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       ///Reject
            //       CommonCircleButton(
            //         iconData: CupertinoIcons.clear,
            //         onPressed: () {},
            //       ),
            //       const SizedBox(width: Sizes.space),

            //       ///Accept
            //       CommonCircleButton(
            //         color: AppColors.green,
            //         iconData: CupertinoIcons.check_mark,
            //         onPressed: () {},
            //       ),
            //     ],
            //   )
          ],
        ),
      ),
    );
  }
}
