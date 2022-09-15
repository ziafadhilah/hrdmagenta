// import 'package:flutter/material.dart';
// import 'package:hrdmagenta/utalities/color.dart';
//
// class CustomAppTheme {
//   ThemeData _themeData;
//
//   CustomAppTheme() {
//     this._themeData = _buildFormAppTheme();
//   }
//
//   ThemeData get data {
//     return _themeData;
//   }
//
//   ThemeData _buildFormAppTheme() {
//     final ThemeData base = ThemeData.light();
//
//     return base.copyWith(
//       accentColor: mRegistrationBlack,
//       primaryColor: mRegistrationBlack,
//       scaffoldBackgroundColor: mFormWhite,
//       cardColor: mFormWhite,
//       errorColor: mFormErrorRed,
//       textTheme: _buildFormAppTextTheme(base.textTheme),
//       primaryTextTheme: _buildFormAppTextTheme(base.textTheme),
//       accentTextTheme: _buildFormAppTextTheme(base.textTheme),
//       primaryIconTheme: base.iconTheme.copyWith(color: mRegistrationBlack),
//       unselectedWidgetColor: mRegistrationBlack,
//     );
//   }
//
// //ther splassscreen
//   ThemeData darktheme() {
//     return ThemeData(
//       brightness: Brightness.dark,
//       //scaffoldBackgroundColor: Color(0xff212224),
//       scaffoldBackgroundColor: Colors.white,
//       textTheme: TextTheme(
//         headline4: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
//         headline5: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w200),
//       ),
//     );
//   }
//
//   ThemeData lighttheme() {
//     return ThemeData(
//       brightness: Brightness.light,
//       // scaffoldBackgroundColor: Color(0xffd6d6d6),
//       scaffoldBackgroundColor: Colors.white,
//       textTheme: TextTheme(
//         headline4: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
//         headline5: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w200),
//       ),
//     );
//   }
//
//   TextTheme _buildFormAppTextTheme(TextTheme base) {
//     return base.copyWith(
//       headline: base.headline.copyWith(
//         fontFamily: 'Cookie',
//         fontSize: 36.0,
//         color: mRegistrationBlack,
//       ),
//       title: base.title.copyWith(
//         fontFamily: 'DINOT',
//         fontSize: 18.0,
//         color: mRegistrationBlack,
//       ),
//       subtitle: base.subtitle.copyWith(
//         fontFamily: 'DINOT',
//         fontSize: 14.0,
//         color: mRegistrationBlack,
//       ),
//       caption: base.caption.copyWith(
//         fontFamily: 'DancingsScript',
//         fontSize: 50.0,
//         color: mRegistrationBlack,
//       ),
//       display1: base.display1.copyWith(
//         fontFamily: 'DancingsScript',
//         fontSize: 14.0,
//         color: mRegistrationBlack,
//       ),
//       button: base.button.copyWith(
//         fontFamily: 'DancingsScript',
//         fontSize: 14.0,
//         color: mFormWhite,
//       ),
//     );
//   }
// }
