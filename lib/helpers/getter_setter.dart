import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AppServices {
  static getScreenHeight(context) => MediaQuery.of(context).size.height;
  static getScreenWidth(context) => MediaQuery.of(context).size.width;

  static addHeight(double height) => SizedBox(height: height);
  static addWidth(double width) => SizedBox(width: width);

  /* Navigation and routing */
  static pushTo(BuildContext context, Widget screen) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => screen));
  static popView(BuildContext context) => Navigator.of(context).pop();

  static pushAndReplace(Widget screen, BuildContext context) =>
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  // navigate to next screen and remove all the screens behind
  static pushAndRemove(Widget screen, BuildContext context) =>
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => screen), (route) => false);

  // function to share my app Link
  static shareMyApp() => Share.share(
      "Download this app or convert any image in any formats. JPG/PNG/PDF/JPEG/WEBP. \nClick Here to Download:- https://play.google.com/store/apps/details?id=com.rohitDev.imageconverter");
}
