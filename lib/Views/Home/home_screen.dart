import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cricket_poc/lib_exports.dart';

part 'Components/home_appbar.dart';
part 'Controller/home_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const _HomeTitleAppBar(),
            const _HomeSearchbarWithCategories(),
          ];
        },
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: Sizes.globalMargin,
          children: [
            const _HeaderText(title: "Featured Services"),
            const FeaturedServicesList(),

            ///
            ///
            ///How it Works
            const SizedBox(height: Sizes.spaceHeightSm),
            const _HeaderText(title: "How It Works"),

            const SizedBox(height: Sizes.spaceHeight),
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(Sizes.borderRadius),
              ),
              tileColor: AppColors.card,
              leading: const Icon(CupertinoIcons.search),
              title: const Text("Find Services"),
              subtitle: const Text(
                  "Browse through our verified game services and select what you need"),
            ),

            const SizedBox(height: Sizes.spaceHeight),
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(Sizes.borderRadius),
              ),
              tileColor: AppColors.card,
              leading: const Icon(CupertinoIcons.calendar),
              title: const Text("Book Time Slot"),
              subtitle: const Text(
                  "Choose your preferred date and time slot for the service"),
            ),

            const SizedBox(height: Sizes.spaceHeight),
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(Sizes.borderRadius),
              ),
              tileColor: AppColors.card,
              leading: const Icon(Icons.school_outlined),
              title: const Text("Enjoy Quality Service"),
              subtitle: const Text(
                  "Experience professional game services from verified providers"),
            ),

            ///
            ///
            ///About Us
            //  _AboutUs(),

            ///CopyRights
            const SizedBox(height: Sizes.spaceHeight),
            const Text(
              "All product names, logos, and brands are property of their respective. All company, product and service names used in this website are for identification purposes only. Use of these names, logos, and brands does not imply endorsement.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Sizes.spaceHeightSm),

            const Text(
              "Copyright @ 2025 GameMate All rights reserved",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: Sizes.spaceHeight),
          ],
        ),
      ),
    );
  }
}

///Header Text Widget
class _HeaderText extends StatelessWidget {
  const _HeaderText({
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

