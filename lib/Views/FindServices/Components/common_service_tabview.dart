import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/material.dart';

class CommonServiceTabview extends StatelessWidget {
  const CommonServiceTabview({
    super.key,
    required this.serviceName,
    required this.serviceData,
  });

  final String serviceName;
  final int serviceData;

  @override
  Widget build(BuildContext context) {
    if (serviceData == 0) {
      return const EmptyDataWidget(
        key: PageStorageKey('CommonServiceTabview'),
        subTitle: "No services found for the selected category.",
      );
    }

    return Column(
      key: const PageStorageKey('CommonServiceTabview'),
      children: [
        ListTile(
          leading: const Icon(Icons.school),
          contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.space),
          title: Text(serviceName),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.space),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return const CardWidget();
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: Sizes.spaceHeight),
          ),
        ),
      ],
    );
  }
}
