# app_tracking_transparency

This Flutter plugin allows you to display ios 14+ tracking authorization dialog and request permission to collect data. Collected data is crucial for ad networks (ie admob) to work efficiently on ios 14+ devices.

## Introduction

Starting in iOS 14, IDFA will be unavailable until an app calls the App Tracking Transparency framework to present the app-tracking authorization request to the end user. If an app does not present this request, the IDFA will automatically be zeroed out which may lead to a significant loss in ad revenue.

This plugin lets you display App Tracking Transparency authorization request and ask for permission.

<div align="left">
    <img src="https://github.com/deniza/app_tracking_transparency/raw/master/images/dialog.png">
</div>

## Usage

Make sure you update Info.plist file located in ios/Runner directory and add the **NSUserTrackingUsageDescription** key with a custom message describing your usage.
```xml
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
```

Google recommends that you should be using Google Mobile Ads SDK 7.64.0 or higher. The Google Mobile Ads SDK supports conversion tracking using Apple's SKAdNetwork, which means Google is able to attribute an app install even when IDFA is unavailable. To enable this functionality, you will need to update the SKAdNetworkItems key with an additional dictionary in your Info.plist.
```xml
<key>SKAdNetworkItems</key>
  <array>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>cstr6suwn9.skadnetwork</string>
    </dict>
  </array>
```

## Example
``` dart
// Import package
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

// Show tracking authorization dialog and ask for permission
final status = await AppTrackingTransparency.requestTrackingAuthorization();

// Now you can safely initialize admob and start to show ads. Admob should use
// advertising identifier automatically.
// FirebaseAdMob.instance.initialize(...)
```

You can also show a custom explainer dialog before the system dialog if you want.
```dart
if (await AppTrackingTransparency.canRequestTrackingAuthorization()) {
  // Show a custom explainer dialog before the system dialog
  if (await showCustomTrackingDialog(context)) {
    // Wait for dialog popping animation
    await Future.delayed(const Duration(milliseconds: 200));
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await AppTrackingTransparency.requestTrackingAuthorization();
    } on PlatformException {
      // Failed to open tracking auth dialog.
    }
  }
}
```

You can also get advertising identifier after authorization. Until a user grants authorization, the UUID returned will be all zeros: 00000000-0000-0000-0000-000000000000. Also note, the advertisingIdentifier will be all zeros in the Simulator, regardless of the tracking authorization status.
```dart
final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
``` 

## Notes
To use this plugin you should compile your project using XCode 12 and run your app on an ios 14 device.

Google (admob) recommends implementing an explainer message that appears to users immediately before the consent dialogue. For additional info on this topic please refer to this article: <https://support.google.com/admob/answer/9997589?hl=en> 
