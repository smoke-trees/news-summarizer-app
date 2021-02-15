// import 'package:fancy_on_boarding/fancy_on_boarding.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:news_summarizer/src/ui/pages/preferences_page.dart';
//
// final pageList = [
//   PageModel(
//       color: const Color(0xFF678FB4),
//       heroImagePath: 'assets/icons/google_logo.png',
//       title: Text('Info',
//           style: TextStyle(
//             fontWeight: FontWeight.w800,
//             color: Colors.white,
//             fontSize: 34.0,
//           )),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Text('Some information about the Summarizer App, also add an informative SVG.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18.0,
//             )),
//       ),
//       iconImagePath: 'assets/icons/google_logo.png'),
//   PageModel(
//       color: const Color(0xFF65B0B4),
//       heroImagePath: 'assets/icons/google_logo.png',
//       title: Text('Banks',
//           style: TextStyle(
//             fontWeight: FontWeight.w800,
//             color: Colors.white,
//             fontSize: 34.0,
//           )),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Text('Some information about the Summarizer App, also add an informative SVG.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18.0,
//             )),
//       ),
//       iconImagePath: 'assets/icons/google_logo.png'),
//   PageModel(
//     color: const Color(0xFF9B90BC),
//     heroImagePath: 'assets/icons/google_logo.png',
//     title: Text('Store',
//         style: TextStyle(
//           fontWeight: FontWeight.w800,
//           color: Colors.white,
//           fontSize: 34.0,
//         )),
//     body: Padding(
//       padding: const EdgeInsets.all(15),
//       child: Text('Some information about the Summarizer App, also add an informative SVG.',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           )),
//     ),
//     icon: Icon(
//       Icons.shopping_cart,
//       color: const Color(0xFF9B90BC),
//     ),
//   ),
//   // SVG Pages Example
//   PageModel(
//       color: const Color(0xFF678FB4),
//       heroImagePath: 'assets/icons/google_logo.png',
//       title: Text('Hotels SVG',
//           style: TextStyle(
//             fontWeight: FontWeight.w800,
//             color: Colors.white,
//             fontSize: 34.0,
//           )),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Text('Some information about the Summarizer App, also add an informative SVG.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18.0,
//             )),
//       ),
//       iconImagePath: 'assets/icons/google_logo.png',
//       heroImageColor: Colors.white),
//   PageModel(
//       color: const Color(0xFF65B0B4),
//       heroImagePath: 'assets/icons/google_logo.png',
//       title: Text('Banks SVG',
//           style: TextStyle(
//             fontWeight: FontWeight.w800,
//             color: Colors.white,
//             fontSize: 34.0,
//           )),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Text('Some information about the Summarizer App, also add an informative SVG.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18.0,
//             )),
//       ),
//       iconImagePath: 'assets/icons/google_logo.png',
//       heroImageColor: Colors.white),
//   PageModel(
//     color: const Color(0xFF9B90BC),
//     heroImagePath: 'assets/icons/google_logo.png',
//     title: Text('Store SVG',
//         style: TextStyle(
//           fontWeight: FontWeight.w800,
//           color: Colors.white,
//           fontSize: 34.0,
//         )),
//     body: Padding(
//       padding: const EdgeInsets.all(15),
//       child: Text('Some information about the Summarizer App, also add an informative SVG.',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           )),
//     ),
//     iconImagePath: 'assets/icons/google_logo.png',
//   ),
// ];
//
// class OnboardingPages extends StatelessWidget {
//   static String routeName = "onboarding_pages";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FancyOnBoarding(
//         doneButtonText: "Done",
//         skipButtonText: "Skip",
//         pageList: pageList,
//         onDoneButtonPressed: () => Get.toNamed(PreferencesPage.routeName),
//         onSkipButtonPressed: () => Get.toNamed(PreferencesPage.routeName),
//       ),
//     );
//   }
// }
