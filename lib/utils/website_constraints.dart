import 'package:flutter/material.dart';

class WebsiteConstraints {
  static bool isWeb(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }
  
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height;
  }
}