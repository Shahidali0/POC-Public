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

List<String> duration = ["30 min", "60 min", "90 min", "2 hrs"];

List<String> timeSlots = [
  "09:00 Am",
  "10:00 Am",
  "11:00 Am",
  "12:00 Pm",
  "01:00 Pm",
  "02:00 Pm",
  "03:00 Pm",
  "04:00 Pm",
  "05:00 Pm",
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

List<String> filters = [
  "Sort",
  "Category",
  "Sub Category",
  "Price",
  "Distance",
];
