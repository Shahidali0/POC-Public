import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostServiceReviewScreen extends ConsumerWidget {
  const PostServiceReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(postServiceControllerPr.notifier);

    final state = ref.watch(postServiceControllerPr);

    return LoadingOverlay(
      isLoading: state.loading,
      child: MyCupertinoSliverScaffold(
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

            ///Service Title, Category Tag, Price Tag
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                controller.serviceTitleController.text.trim().capitalizeFirst,
                style: const TextStyle(
                  fontSize: Sizes.fontSize18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appTheme,
                ),
              ),
              subtitle: Text(
                "${state.selectedCategory} - (${state.selectedSubCategory})",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: AppColors.orange,
                  fontSize: Sizes.fontSize12,
                ),
              ),
              trailing: Text(
                "\$ ${controller.priceController.text.trim()}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: kDefaultFontSize,
                ),
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
            _VerticalTile(
              header: "Duration",
              body: state.selectedSessionDuration.getDuration,
              iconData: CupertinoIcons.time,
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
            _AvailableDatesWidget(selectedDays: state.selectedDates.toList()),

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
                state.selectedTimeSlots.length,
                (index) => ActionChip.elevated(
                  onPressed: () {},
                  labelPadding: const EdgeInsets.all(Sizes.spaceSmall),
                  padding:
                      const EdgeInsets.symmetric(horizontal: Sizes.spaceHeight),
                  avatar: const Icon(
                    CupertinoIcons.time,
                    color: AppColors.black,
                  ),
                  label: Text(
                    state.selectedTimeSlots[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).toList(),
            )
          ],
        ),
      ),
    );
  }
}

///Available Dates Widget
class _AvailableDatesWidget extends StatelessWidget {
  const _AvailableDatesWidget({
    required this.selectedDays,
  });

  final List<DateTime> selectedDays;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Sizes.space,
      children: List.generate(
        selectedDays.length,
        (index) {
          return ActionChip.elevated(
            onPressed: () {},
            labelPadding: const EdgeInsets.all(Sizes.spaceSmall),
            padding: const EdgeInsets.symmetric(horizontal: Sizes.spaceHeight),
            avatar: const Icon(
              CupertinoIcons.calendar,
              color: AppColors.black,
            ),
            label: Text(
              selectedDays[index].formatDateToString,
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
  });

  final String header;
  final String body;
  final IconData? iconData;

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
            horizontalTitleGap: 8,
            dense: true,
            leading: iconData != null ? Icon(iconData) : null,
            title: Text(
              body,
              style: const TextStyle(
                fontSize: Sizes.fontSize16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
