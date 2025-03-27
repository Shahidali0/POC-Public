import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostServiceReviewScreen extends ConsumerWidget {
  const PostServiceReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(postServiceControllerPr.notifier);

    return MyCupertinoSliverScaffold(
      title: "Post Service",
      bottomNavBar: SafeArea(
        minimum: Sizes.globalMargin,
        child: CommonButton(
          onPressed: () => controller.postService(context),
          text: "Post Service",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Text(
            "Review & Submit",
            style: TextStyle(
              fontSize: Sizes.fontSize18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const Text("Review your service details before posting"),
          const SizedBox(height: Sizes.spaceHeight),

          ///Service Title
          Text(
            controller.serviceTitleController.text.trim(),
            style: const TextStyle(
              fontSize: Sizes.fontSize18,
              fontWeight: FontWeight.bold,
              color: AppColors.appTheme,
            ),
          ),

          ///Category Tag
          Text(
            controller.selectedServiceCategory.value ?? "--",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              color: AppColors.orange,
            ),
          ),

          ///Location
          ListTile(
            minVerticalPadding: 0,
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const Icon(CupertinoIcons.map_pin_ellipse),
            title: Text(
              controller.locationController.text.trim(),
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: Sizes.fontSize16,
              ),
            ),
          ),
          const Divider(),

          ///Description
          _VerticalTile(
            header: "Description",
            body: controller.serviceDescriptionController.text.trim(),
          ),

          ///Duration and Price
          Row(
            children: [
              Expanded(
                child: _VerticalTile(
                  header: "Duration",
                  body: Utils.instance.getDuration(
                    controller.selectedSessionDurationListenable.value,
                    skipMinutesText: true,
                  ),
                  iconData: CupertinoIcons.time,
                ),
              ),
              Expanded(
                child: _VerticalTile(
                  header: "Price",
                  body: controller.priceController.text.trim(),
                  iconData: Icons.attach_money,
                  // CupertinoIcons.money_dollar_circle,
                  bodyColor: AppColors.appTheme,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          ///Available Dates
          const SizedBox(height: Sizes.space),
          const Text(
            "Available Dates:",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.black,
              fontSize: Sizes.fontSize16,
            ),
          ),
          const SizedBox(height: Sizes.spaceMed),
          _AvailableDatesWidget(controller: controller),

          ///Available TimeSlots
          const SizedBox(height: Sizes.space),
          const Text(
            "Available Times:",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.black,
              fontSize: Sizes.fontSize16,
            ),
          ),
          const SizedBox(height: Sizes.spaceMed),
          Wrap(
            spacing: Sizes.space,
            children: List.generate(
              controller.selectedTimeSlotsListenable.value.length,
              (index) => Chip(
                labelPadding: const EdgeInsets.all(Sizes.spaceSmall),
                padding:
                    const EdgeInsets.symmetric(horizontal: Sizes.spaceHeight),
                avatar: const Icon(
                  CupertinoIcons.time,
                  color: AppColors.black,
                ),
                label: Text(
                  controller.selectedTimeSlotsListenable.value[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ).toList(),
          )
        ],
      ),
    );
  }
}

///Available Dates Widget
class _AvailableDatesWidget extends StatelessWidget {
  const _AvailableDatesWidget({
    required this.controller,
  });

  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    final selectedDays = controller.selectedDays.toList();

    return Wrap(
      spacing: Sizes.space,
      children: List.generate(
        selectedDays.length,
        (index) {
          return Chip(
            labelPadding: const EdgeInsets.all(Sizes.spaceSmall),
            padding: const EdgeInsets.symmetric(horizontal: Sizes.spaceHeight),
            avatar: const Icon(
              CupertinoIcons.calendar,
              color: AppColors.black,
            ),
            label: Text(
              Utils.instance.formatDateToString(selectedDays[index]),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

///Custom Vertical Tile
class _VerticalTile extends StatelessWidget {
  const _VerticalTile({
    required this.header,
    required this.body,
    this.iconData,
    this.bodyColor = AppColors.black,
    this.fontWeight = FontWeight.normal,
  });

  final String header;
  final String body;
  final IconData? iconData;
  final Color bodyColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: Sizes.space),
        Text(
          "$header: ",
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.black,
            fontSize: Sizes.fontSize16,
          ),
        ),
        Flexible(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: Sizes.spaceMed,
            minTileHeight: 0,
            horizontalTitleGap: 3,
            dense: true,
            iconColor: bodyColor,
            textColor: bodyColor,
            leading: iconData != null ? Icon(iconData) : null,
            title: Text(
              body,
              style: TextStyle(
                fontSize: Sizes.fontSize16,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
