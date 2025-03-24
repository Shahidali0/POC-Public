// import 'package:flutter/material.dart';

// import 'package:cricket_poc/lib_exports.dart';

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   String locationMessage = "Tap the button to get location";

//   ///Get Current address
//   Future<void> getAddressFromLatLng(double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latitude, longitude);

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         String address =
//             "${place.subLocality}, ${place.locality}, ${place.country}";

//         print("User Area: $address");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   ///Get Current Location
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       setState(() => locationMessage = "Location services are disabled.");
//       return;
//     }

//     // Check for permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() => locationMessage = "Location permission denied.");
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       setState(
//           () => locationMessage = "Location permission permanently denied.");
//       return;
//     }

//     // Get current position
//     Position position = await Geolocator.getCurrentPosition(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 100,
//       ),
//     );

//     setState(() {
//       locationMessage =
//           "Lat: ${position.latitude}, Long: ${position.longitude}";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("User Location Example")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(locationMessage, textAlign: TextAlign.center),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _getCurrentLocation,
//               child: const Text("Get Location"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
