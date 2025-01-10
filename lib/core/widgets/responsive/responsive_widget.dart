import 'package:flutter/material.dart';

/// A responsive layout widget that displays different content based on the screen width.
///
/// This widget allows you to build adaptive layouts by providing different widgets for mobile, tablet, 
/// and desktop screen sizes. It uses `MediaQuery` to determine the screen width and adjust the displayed 
/// widget accordingly, ensuring an optimal layout across various devices.
class Responsive extends StatelessWidget {
  /// The widget to display on mobile devices.
  final Widget mobile;

  /// The widget to display on tablet devices. If not provided, the [mobile] widget will be used as fallback.
  final Widget? tablet;

  /// The widget to display on desktop devices.
  final Widget desktop;

  /// Creates a [Responsive] widget with the given mobile, tablet, and desktop widgets.
  ///
  /// The `mobile` and `desktop` widgets are required, while the `tablet` widget is optional. If not provided, 
  /// the [mobile] widget will be used for tablets.
  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  /// Returns `true` if the current screen size is considered mobile.
  ///
  /// A mobile device is considered any screen width smaller than 904 pixels.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 904;

  /// Returns `true` if the current screen size is considered tablet.
  ///
  /// A tablet device is considered any screen width between 904 pixels and 1280 pixels (exclusive).
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 904 && MediaQuery.of(context).size.width < 1280;

  /// Returns `true` if the current screen size is considered desktop.
  ///
  /// A desktop device is considered any screen width larger than or equal to 1280 pixels.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1280;

  @override
  Widget build(BuildContext context) {
    // Determine the screen size using MediaQuery
    final Size _size = MediaQuery.of(context).size;

    // Choose which widget to display based on the screen size
    if (_size.width >= 1280) {
      return desktop;
    } else if (_size.width >= 904) {
      // Use the tablet widget if available, otherwise fallback to mobile
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }
}
