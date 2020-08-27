# app_tracking_transparency

This Flutter plugin allows you to display ios 14+ tracking authorization dialog and request permission to collect data. Collected data is crucial for ad networks (ie admob) to work efficiently on ios 14+ devices.

## Introduction

Starting in iOS 14, IDFA will be unavailable until an app calls the App Tracking Transparency framework to present the app-tracking authorization request to the end user. If an app does not present this request, the IDFA will automatically be zeroed out which may lead to a significant loss in ad revenue.

This plugin lets you display App Tracking Transparency authorization request and ask for permission.

## Usage

To use this plugin, follow the [installing guide](https://pub.dev/packages/app_tracking_transparency#-installing-tab-).

Make sure you update Info.plist file located in ios/Runner directory and add the NSUserTrackingUsageDescription key with a custom message describing your usage.
```xml
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
```

## Example
``` dart
// Import package
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

// Show tracking authorization dialog and ask for permission
final status = await AppTrackingTransparency.requestTrackingAuthorization();
```

You can also get advertising identifier after authorization if you want.
```dart
final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
``` 

## Notes
To use this plugin you should compile your project using XCode 12 and run your app on an ios 14 device.
