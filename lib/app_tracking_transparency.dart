import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum TrackingStatus {
  /// The user has not yet received an authorization request dialog
  notDetermined,

  /// The device is restricted, tracking is disabled and the system can't show a request dialog
  restricted,

  /// The user denies authorization for tracking
  denied,

  /// The user authorizes access to tracking
  authorized,

  /// The platform is not iOS or the iOS version is below 14.0
  notSupported,
}

class AppTrackingTransparency {
  static const MethodChannel _channel =
      const MethodChannel('app_tracking_transparency');

  /// Get tracking authorization status without showing a dialog.
  ///
  /// Consider using this value if you want to show a custom tracking
  /// explainer dialog before the system dialog.
  ///
  /// ```dart
  /// // If the system can show an authorization request dialog
  /// if (await AppTrackingTransparency.trackingAuthorizationStatus ==
  ///     TrackingStatus.notDetermined) {
  ///   // Show a custom explainer dialog before the system dialog
  ///   await showCustomTrackingDialog(context);
  ///   // Wait for dialog popping animation
  ///   await Future.delayed(const Duration(milliseconds: 200));
  ///   // Request system's tracking authorization dialog
  ///   await AppTrackingTransparency.requestTrackingAuthorization();
  /// }
  /// ```
  ///
  /// returns TrackingStatus.notSupported on Android
  static Future<TrackingStatus> get trackingAuthorizationStatus async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final int status =
          (await _channel.invokeMethod<int>('getTrackingAuthorizationStatus'))!;
      return TrackingStatus.values[status];
    }
    return TrackingStatus.notSupported;
  }

  /// Call this function to display tracking authorization dialog on ios 14+ devices.
  /// User's choice is returned as [TrackingStatus]. You can call this function as many
  /// as you want but it will display the dialog only once after the user mades his decision.
  ///
  /// ```dart
  /// final status = await AppTrackingTransparency.requestTrackingAuthorization();
  /// ```
  ///
  /// returns TrackingStatus.notSupported on Android
  static Future<TrackingStatus> requestTrackingAuthorization() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final int status =
          (await _channel.invokeMethod<int>('requestTrackingAuthorization'))!;
      return TrackingStatus.values[status];
    }
    return TrackingStatus.notSupported;
  }

  /// Call this function to get advertising identifier (ie tracking data).
  /// ```dart
  /// final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
  /// ```
  /// returns empty string on Android
  static Future<String> getAdvertisingIdentifier() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final String uuid =
          (await _channel.invokeMethod<String>('getAdvertisingIdentifier'))!;
      return uuid;
    }
    return "";
  }
}
