import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

enum TrackingStatus { notDetermined, restricted, denied, authorized }

class AppTrackingTransparency {
  static const MethodChannel _channel =
      const MethodChannel('app_tracking_transparency');

  /// This function returns true if platform is iOS, iOS version is 14.0+ and
  /// authorization status is not determined. If you want to show a custom
  /// tracking explainer dialog before the system dialog, consider calling this
  /// function before [requestTrackingAuthorization]. This ensures that the
  /// system will show the dialog if the custom tracking dialog accepted.
  ///
  /// ```dart
  /// if (await AppTrackingTransparency.canRequestTrackingAuthorization()) {
  ///   // Show a custom explainer dialog before the system dialog
  ///   if (await showCustomTrackingDialog(context)) {
  ///     // Wait for dialog popping animation
  ///     await Future.delayed(const Duration(milliseconds: 200));
  ///     // Platform messages may fail, so we use a try/catch PlatformException.
  ///     try {
  ///       await AppTrackingTransparency.requestTrackingAuthorization();
  ///     } on PlatformException {
  ///       // Failed to open tracking auth dialog.
  ///     }
  ///   }
  /// }
  /// ```
  ///
  /// Returns true if the system can show the tracking request dialog.
  static Future<bool> canRequestTrackingAuthorization() async {
    if (Platform.isIOS) {
      try {
        final bool isAvailable =
            await _channel.invokeMethod('canRequestTrackingAuthorization');
        return isAvailable;
      } on PlatformException {}
    }
    return false;
  }

  /// Call this function to display tracking authorization dialog on ios 14+ devices.
  /// User's choice is returned as [TrackingStatus]. You can call this function as many
  /// as you want but it will display the dialog only once after the user mades his decision.
  ///
  /// ```dart
  /// final status = await AppTrackingTransparency.requestTrackingAuthorization();
  /// ```
  ///
  static Future<TrackingStatus> requestTrackingAuthorization() async {
    final int status =
        await _channel.invokeMethod('requestTrackingAuthorization');
    return TrackingStatus.values[status];
  }

  /// Call this function to get advertising identifier (ie tracking data).
  /// ```dart
  /// final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
  /// ```
  static Future<String> getAdvertisingIdentifier() async {
    final String uuid = await _channel.invokeMethod('getAdvertisingIdentifier');
    return uuid;
  }
}
