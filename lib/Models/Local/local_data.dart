import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///These are sub Categories
List<String> specializationsData = [
  "Batting Training",
  "Bowling Training",
  "Fielding Practice",
  "Wicket Keeping",
  "Mental Training",
];

///Duration Count
List<String> durationData = ["30 min", "60 min", "90 min", "120 min"];

///Time Slot Data
List<String> timeSlotsData = [
  "09:00 AM",
  "10:00 AM",
  "11:00 AM",
  "12:00 PM",
  "01:00 PM",
  "02:00 PM",
  "03:00 PM",
  "04:00 PM",
  "05:00 PM",
];

///My Service Tabs
List<String> myServicesTabsData = [
  "My Services",
  "My Booking",
];

///HomePage Tabs Data
List<HomeTabbarItem> homeTabbarItemsData = [
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
    title: "EquiPMent Rental",
  ),
  HomeTabbarItem(
    iconData: CupertinoIcons.location,
    title: "Grounds",
  ),
];
