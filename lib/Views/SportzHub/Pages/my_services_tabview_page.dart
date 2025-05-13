import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyServicesTabviewPage extends ConsumerWidget {
  const MyServicesTabviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(getMyServicesListFtPr.future),
      child: ref.watch(getMyServicesListFtPr).when(
            data: (data) {
              ///For Empty Services List
              if (data == null || (data.services?.isEmpty ?? false)) {
                return EmptyDataWidget(
                  subTitle: Constants.emptyMyServices,
                  widget: CommonOutlineButton(
                    minButtonWidth: 100,
                    dense: true,
                    onPressed: () => AppRouter.instance.animatedPush(
                      context: context,
                      page: const PostServiceScreen(),
                    ),
                    text: "Post Service",
                  ),
                );
              }

              return _body(
                context: context,
                myServices: data.services!,
                ref: ref,
              );
            },
            error: (e, st) {
              final error = e as Failure;
              return ErrorText(
                title: error.title,
                error: error.message,
                onRefresh: () async => ref.invalidate(getMyServicesListFtPr),
              );
            },
            loading: () => const ShowDataLoader(),
          ),
    );
  }

  ///Body Widget
  Widget _body({
    required List<ServiceJson> myServices,
    required WidgetRef ref,
    required BuildContext context,
  }) =>
      ListView.separated(
        key: const PageStorageKey('MyServicesTabview'),
        physics: const NeverScrollableScrollPhysics(),
        padding: Sizes.globalMargin.add(
          const EdgeInsets.only(bottom: Sizes.spaceHeight * 5),
        ),
        itemCount: myServices.length,
        itemBuilder: (BuildContext context, int index) {
          return _MyServiceCard(
            serviceJson: myServices[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: Sizes.spaceHeight),
      );
}

///Service Card Widget
class _MyServiceCard extends StatelessWidget {
  const _MyServiceCard({
    required this.serviceJson,
  });

  final ServiceJson serviceJson;

  void _onViewDetails(BuildContext context) => AppRouter.instance.push(
        context: context,
        page: MyServiceDetailsPage(serviceJson: serviceJson),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onViewDetails(context),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              CupertinoListTile(
                padding: const EdgeInsets.symmetric(vertical: Sizes.space),
                leadingSize: 0,
                leadingToTitle: 0,
                title: Text(
                  serviceJson.title!,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: Sizes.fontSize18,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                subtitle: Text(
                  serviceJson.description?.capitalize ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.blueGrey,
                  ),
                ),
                trailing: Text(
                  "\$ ${serviceJson.price}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Sizes.fontSize16,
                  ),
                ),
              ),

              ///Location
              CustomListTile(
                iconData: CupertinoIcons.map_pin_ellipse,
                text: serviceJson.location!,
              ),

              ///Duration
              CustomListTile(
                iconData: CupertinoIcons.time,
                text: serviceJson.duration.getDuration,
              ),

              ///View Details Button
              CommonTextButton(
                onPressed: () => _onViewDetails(context),
                text: "View Details",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
