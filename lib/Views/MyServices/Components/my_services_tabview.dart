import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyServicesTabview extends StatelessWidget {
  const MyServicesTabview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const PageStorageKey('MyServicesTabview'),
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Sizes.space),
      itemCount: 30,
      itemBuilder: (BuildContext context, int index) {
        return const _MyServiceCard();
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: Sizes.spaceHeight),
    );
  }
}

///Service Card Widget
class _MyServiceCard extends StatelessWidget {
  const _MyServiceCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRouter.instance.push(
        context: context,
        screen: const FindServiceDetailsScreen(),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: Sizes.globalPadding,
          child: Stack(
            children: [
              ///Card Items
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Header
                  ///Header
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Professional Batting Practice",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Sizes.fontSize18,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      ///Price Tag
                      Text(
                        r"$ 59",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizes.fontSize16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  ///Tag
                  _buildListTile(
                    iconData: CupertinoIcons.person,
                    text: "John Smith",
                    color: AppColors.blueGrey,
                    context: context,
                  ),

                  ///Description
                  const SizedBox(height: Sizes.space),
                  const Text(
                    "One-on-one batting practice sessions with experienced players",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: Sizes.fontSize16,
                    ),
                  ),
                  const SizedBox(height: Sizes.space),

                  ///Details
                  _buildListTile(
                    iconData: CupertinoIcons.pin,
                    text: "Melbourne Cricket Ground",
                    context: context,
                  ),
                  _buildListTile(
                    iconData: CupertinoIcons.time,
                    text: "30 or 60 mins",
                    context: context,
                  ),

                  // _buildListTile(
                  //   iconData: CupertinoIcons.money_dollar,
                  //   text: "40 per session",
                  //   color: AppColors.appTheme,
                  //   fontWeight: FontWeight.w700,
                  //   iconSize: 18,
                  // ),
                ],
              ),

              const Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Custom ListTile
  Widget _buildListTile({
    required IconData iconData,
    required String text,
    required BuildContext context,
    double? iconSize,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      ListTile(
        minTileHeight: 12,
        minVerticalPadding: 4,
        dense: true,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 2,
        visualDensity: VisualDensity.compact,
        leading: Icon(
          iconData,
          size: iconSize ?? 16,
          color: color,
        ),
        title: Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: kDefaultFontSize,
            color: color ?? AppColors.black,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
        ),
      );
}
