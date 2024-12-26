import 'package:flutter/cupertino.dart';

class Responsive extends StatelessWidget{
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({super.key, required this.mobile, this.tablet, required this.desktop});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 904;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 904 && MediaQuery.of(context).size.width < 1280;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1280;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= 1280) {
      return desktop;
    } else if (_size.width >= 904) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }
}