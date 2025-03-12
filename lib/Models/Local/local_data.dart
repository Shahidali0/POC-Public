import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> idTypes = [
  "Passport",
  "Driving License",
  "National Id",
];

List<String> specializations = [
  "Batting Training",
  "Bowling Training",
  "Fielding Practice",
  "Wicket Keeping",
  "Mental Training",
];

List<String> findServicesTabs = [
  "All Services",
  "Batting",
  "Bowling",
  "Fielding",
  "Match Organization",
  "Find Teams",
  "Hire Equipment",
];

List<String> myServicesTabs = [
  "My Services",
  "My Booking",
];

List<HomeTabbarItem> homeTabbarItems = [
  HomeTabbarItem(
    iconData: CupertinoIcons.home,
    title: "All Services",
  ),
  HomeTabbarItem(
    iconData: CupertinoIcons.person,
    title: "Coaching",
  ),
  HomeTabbarItem(
    iconData: CupertinoIcons.calendar_today,
    title: "Match Organization",
  ),
  HomeTabbarItem(
    iconData: Icons.car_rental,
    title: "Equipment Rental",
  ),
  HomeTabbarItem(
    iconData: CupertinoIcons.location,
    title: "Grounds",
  ),
];
