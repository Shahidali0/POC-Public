import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Card Widget to show service details
class ServiceCardWidget extends StatelessWidget {
  const ServiceCardWidget({
    super.key,
    required this.serviceJson,
  });

  final ServiceJson serviceJson;

  ///OnTap BookNow
  void _onBookNow(BuildContext context) => AppRouter.instance.push(
        context: context,
        page: ServiceDetailsScreen(serviceJson: serviceJson),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onBookNow(context),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: Sizes.globalMargin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      serviceJson.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: Sizes.fontSize16,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: Sizes.spaceMed),

                  ///Price Tag
                  Text(
                    "\$ ${serviceJson.price}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: Sizes.fontSize16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: Sizes.spaceMed),

              ///Tag
              CustomTile(
                iconData: CupertinoIcons.tag,
                text:
                    "${serviceJson.category!.capitalizeFirst} (${serviceJson.sport!.capitalizeFirst})",
              ),

              ///Details
              CustomTile(
                iconData: CupertinoIcons.map_pin_ellipse,
                text: serviceJson.location!,
              ),

              CustomTile(
                iconData: CupertinoIcons.timer,
                text: Utils.instance.getDuration(serviceJson.duration),
              ),

              ///View Details Button
              CommonTextButton(
                onPressed: () => _onBookNow(context),
                text: "View Details",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
