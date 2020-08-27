import 'dart:async';
import 'package:flutter/services.dart';

enum TrackingStatus { notDetermined, restricted, denied, authorized }

class AppTrackingTransparency {
  static const MethodChannel _channel =
      const MethodChannel('app_tracking_transparency');

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
