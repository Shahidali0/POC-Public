import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HowItWorksData {
  final IconData iconData;
  final String title;
  final String description;

  HowItWorksData(
      {required this.iconData, required this.title, required this.description});
}

final howItWorksData = <HowItWorksData>[
  ///Item 1 -- Find Services
  HowItWorksData(
    iconData: CupertinoIcons.search,
    title: "Find Services",
    description:
        "Browse through our verified game services and select what you need",
  ),

  /// Item 2 --Book Time Slot
  HowItWorksData(
    iconData: CupertinoIcons.calendar_today,
    title: "Book Time Slot",
    description: "Choose your preferred date and time slot for the service",
  ),

  ///Item 3 --Make Payment
  HowItWorksData(
    iconData: Icons.payment_outlined,
    title: "Make Payment",
    description:
        "Securely pay for the service using our trusted payment gateway",
  ),

  ///Item 4 --Secure & Reliable
  HowItWorksData(
    iconData: Icons.security_outlined,
    title: "Secure & Reliable",
    description: "Your data and transactions are safe with us",
  ),

  ///Item 5 --Enjoy Quality Service
  HowItWorksData(
    iconData: Icons.school_outlined,
    title: "Enjoy Quality Service",
    description:
        "Experience professional game services from verified providers",
  ),
];
