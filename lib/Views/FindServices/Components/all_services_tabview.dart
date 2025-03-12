import 'package:cricket_poc/lib_exports.dart';

import 'package:flutter/material.dart';

class AllServicesTabview extends StatelessWidget {
  const AllServicesTabview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ///Match Organization
        const CustomTile(
          iconData: Icons.school,
          text: "Match Organization",
        ),
        SizedBox(
          height: 340,
          child: ColoredBox(
            color: AppColors.border,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(Sizes.space),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const CardWidget(),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: Sizes.space),
            ),
          ),
        ),

        ///Batting
        const CustomTile(
          iconData: Icons.school,
          text: "Batting",
        ),
        SizedBox(
          height: 340,
          child: ColoredBox(
            color: AppColors.border,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(Sizes.space),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const CardWidget(),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: Sizes.space),
            ),
          ),
        ),

        ///Bowling
        const CustomTile(
          iconData: Icons.school,
          text: "Bowling",
        ),
        SizedBox(
          height: 340,
          child: ColoredBox(
            color: AppColors.border,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(Sizes.space),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const CardWidget(),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: Sizes.space),
            ),
          ),
        )
      ],
    );
  }
}
