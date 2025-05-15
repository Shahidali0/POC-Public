import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

part 'Components/home_appbar.dart';
part 'Controller/home_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RefreshIndicator(
        displacement: 120,
        onRefresh: () => ref.refresh(getFeaturedServicesFtPr.future),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const _HomeTitleAppBar(),
              const _HomeSearchbarWithCategories(),
            ];
          },
          body: ListView(
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            padding: Sizes.globalMargin,
            children: [
              const FeaturedServicesList(),

              ///How it Works
              ..._howItWorks(context),

              ///About Us
              //  _AboutUs(),

              ///CopyRights
              ..._copyRights(context),
            ],
          ),
        ),
      ),
    );
  }

  ///How it Works Widget
  List<Widget> _howItWorks(BuildContext context) {
    return [
      const HomeHeaderText(title: "How It Works"),
      const SizedBox(height: Sizes.spaceHeight),
      ExpansionPanelList.radio(
        elevation: 1,
        dividerColor: AppColors.border,
        materialGapSize: Sizes.spaceHeight,
        expandedHeaderPadding: EdgeInsets.zero,
        children: howItWorksData
            .map(
              (item) => ExpansionPanelRadio(
                value: item,
                canTapOnHeader: true,
                backgroundColor: AppColors.card,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    leading: Icon(item.iconData),
                    title: Text(item.title),
                  );
                },
                body: ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  title: Text(
                    item.description,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            )
            .toList(),
      )
    ];
  }
  // ///How it Works Widget
  // List<Widget> _howItWorks() {
  //   return [
  //     const SizedBox(height: Sizes.spaceHeightSm),
  //     const _HeaderText(title: "How It Works"),
  //     const SizedBox(height: Sizes.spaceHeight),
  //     ///Item 1 --Find Services
  //     ListTile(
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(color: AppColors.border),
  //         borderRadius: BorderRadius.circular(Sizes.borderRadius),
  //       ),
  //       tileColor: AppColors.card,
  //       leading: const Icon(CupertinoIcons.search),
  //       title: const Text("Find Services"),
  //       subtitle: const Text(
  //           "Browse through our verified game services and select what you need"),
  //     ),
  //     const SizedBox(height: Sizes.spaceHeight),
  //     ///Item 2 --Book Time Slot
  //     ListTile(
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(color: AppColors.border),
  //         borderRadius: BorderRadius.circular(Sizes.borderRadius),
  //       ),
  //       tileColor: AppColors.card,
  //       leading: const Icon(CupertinoIcons.calendar_today),
  //       title: const Text("Book Time Slot"),
  //       subtitle: const Text(
  //           "Choose your preferred date and time slot for the service"),
  //     ),
  //     const SizedBox(height: Sizes.spaceHeight),
  //     ///Item 3 --Enjoy Quality Service
  //     ListTile(
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(color: AppColors.border),
  //         borderRadius: BorderRadius.circular(Sizes.borderRadius),
  //       ),
  //       tileColor: AppColors.card,
  //       leading: const Icon(Icons.school_outlined),
  //       title: const Text("Enjoy Quality Service"),
  //       subtitle: const Text(
  //         "Experience professional game services from verified providers",
  //       ),
  //     ),
  //     ///Item 4 --Make Payment
  //     const SizedBox(height: Sizes.spaceHeight),
  //     ListTile(
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(color: AppColors.border),
  //         borderRadius: BorderRadius.circular(Sizes.borderRadius),
  //       ),
  //       tileColor: AppColors.card,
  //       leading: const Icon(Icons.payment_outlined),
  //       title: const Text("Make Payment"),
  //       subtitle: const Text(
  //           "Securely pay for the service using our trusted payment gateway"),
  //     ),
  //     const SizedBox(height: Sizes.spaceHeight),
  //     ///Item 5 --Secure & Reliable
  //     ListTile(
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(color: AppColors.border),
  //         borderRadius: BorderRadius.circular(Sizes.borderRadius),
  //       ),
  //       tileColor: AppColors.card,
  //       leading: const Icon(Icons.security_outlined),
  //       title: const Text("Secure & Reliable"),
  //       subtitle: const Text("Your data and transactions are safe with us"),
  //     ),
  //   ];
  // }

  ///CopyRights Widget
  List<Widget> _copyRights(BuildContext context) {
    return [
      const SizedBox(height: Sizes.spaceHeight),
      const Text(
        Constants.copyRightInfo,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: Sizes.spaceHeightSm),
      Text(
        Constants.copyRight,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.black,
              fontFamily: AppTheme.boldFont,
            ),
      ),
      const SizedBox(height: Sizes.spaceHeight),
    ];
  }
}

///Header Text Widget
class HomeHeaderText extends StatelessWidget {
  const HomeHeaderText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: Sizes.fontSize20,
        fontWeight: FontWeight.w800,
        color: AppColors.appTheme,
      ),
    );
  }
}

// ///Custom Rich Text Widget
// class _MyRichText extends StatelessWidget {
//   const _MyRichText({
//     required this.title,
//     required this.subTitle,
//   });
//   final String title;
//   final String subTitle;
//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       text: TextSpan(
//         style: const TextStyle(
//           fontSize: Sizes.fontSize16,
//           fontWeight: FontWeight.bold,
//         ),
//         text: title,
//         children: [
//           TextSpan(
//             text: subTitle,
//             style: const TextStyle(
//               fontWeight: FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

///About Us Card
// class _AboutUs extends StatelessWidget {
//   const _AboutUs({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//          const SizedBox(height: Sizes.spaceHeight),
//             const _HeaderText(title: "Contact Us"),
//             const SizedBox(height: Sizes.spaceHeight),
//             Card(
//               margin: EdgeInsets.zero,
//               child: Padding(
//                 padding: Sizes.globalPadding,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "GameMate Private Limited",
//                       style: TextStyle(
//                         fontSize: Sizes.fontSize16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Text(
//                       "ABC, 3rd Floor, Industrial Area Phase-2, Australia",
//                     ),
//                     ///Email
//                     const SizedBox(height: Sizes.spaceHeight),
//                     const Text(
//                       "Email us:",
//                       style: TextStyle(
//                         fontSize: Sizes.fontSize16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Text(
//                       "contactus@xyz.com",
//                       style: TextStyle(fontSize: Sizes.fontSize16),
//                     ),
//                     ///Follow Us
//                     const SizedBox(height: Sizes.spaceHeight),
//                     const Text(
//                       "Follow us:",
//                       style: TextStyle(
//                         fontSize: Sizes.fontSize16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: Sizes.spaceHeightSm),
//                     Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ///FaceBook
//                         GestureDetector(
//                           onTap: () {},
//                           child: const CircleAvatar(
//                             backgroundColor: Colors.blue,
//                             radius: 22,
//                             child: FaIcon(
//                               FontAwesomeIcons.facebookF,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: Sizes.space),
//                         ///Twitter
//                         GestureDetector(
//                           onTap: () {},
//                           child: const CircleAvatar(
//                             backgroundColor: Colors.cyan,
//                             radius: 22,
//                             child: FaIcon(
//                               FontAwesomeIcons.twitter,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: Sizes.space),
//                         ///Youtube
//                         GestureDetector(
//                           onTap: () {},
//                           child: const CircleAvatar(
//                             backgroundColor: Colors.red,
//                             radius: 22,
//                             child: FaIcon(
//                               FontAwesomeIcons.youtube,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: Sizes.space),
//                         ///Instagram
//                         GestureDetector(
//                           onTap: () {},
//                           child: const CircleAvatar(
//                             backgroundColor: Colors.pink,
//                             radius: 22,
//                             child: FaIcon(
//                               FontAwesomeIcons.instagram,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: Sizes.space),
//                         ///LinkedIn
//                         GestureDetector(
//                           onTap: () {},
//                           child: const CircleAvatar(
//                             backgroundColor: Colors.indigo,
//                             radius: 22,
//                             child: FaIcon(
//                               FontAwesomeIcons.linkedin,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: Sizes.space),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//       ],
//     );
//   }
// }
