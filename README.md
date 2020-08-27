# app_tracking_transparency

This Flutter plugin allows you to display ios 14+ tracking authorization dialog and request permission to collect data. Collected data is crucial for ad networks (ie admob) to work efficiently on ios 14+ devices.

## Usage

To use this plugin, follow the [installing guide](https://pub.dev/packages/app_tracking_transparency#-installing-tab-).

Make sure you add following key/value pair to your Info.plist file located in ios/Runner directory.
```
<key>NSUserTrackingUsageDescription</key>
<string>We request tracking permission to show you relevant, personalized ads.</string>
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
