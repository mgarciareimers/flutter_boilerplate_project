import 'package:flutter/material.dart';

// Pages.
import 'package:flutter_boilerplate_project/src/pages/home_page.dart';

class Routes {
  static const String home = 'home';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      home: (BuildContext context) => const HomePage(),
    };
  }
}