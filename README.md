# app_tracking_transparency

This Flutter plugin allows you to display ios 14+ tracking authorization dialog and request permission to collect data. Collected data is crucial for ad networks (ie admob) to work efficiently on ios 14+ devices.

## Introduction

Starting in iOS 14.0 App Tracking Transparency framework is available so we can present the app-tracking authorization request to the end user.

Starting in iOS 14.5, IDFA will be unavailable until an app calls the App Tracking Transparency framework to present the app-tracking authorization request to the end user. If an app does not present this request, the IDFA will automatically be zeroed out which may lead to a significant loss in ad revenue.

On iOS >=14.0 <14.5, tracking authorization request dialog isn't required in order to get IDFA. Keep in mind that, in those iOS versions, if you ask for it and the user rejects it you will lose access to IDFA ([see tests](https://github.com/deniza/app_tracking_transparency/pull/6#issuecomment-808964367)).

This plugin lets you display App Tracking Transparency authorization request and ask for permission.

<div align="left">
    <img src="https://github.com/deniza/app_tracking_transparency/raw/master/images/dialog.png">
</div>

## Usage

#### Step 1:
Make sure you update Info.plist file located in ios/Runner directory and add the **NSUserTrackingUsageDescription** key with a custom message describing your usage.
```xml
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
```
#### Step 2:
Google recommends that you should be using Google Mobile Ads SDK 7.64.0 or higher. The Google Mobile Ads SDK supports conversion tracking using Apple's SKAdNetwork, which means Google is able to attribute an app install even when IDFA is unavailable. **This is a crucial step if you want to maximize your ad revenue when IDFA is not available.** To enable this functionality, you will need to update the SKAdNetworkItems key with an additional dictionary in your Info.plist, [check them here](https://developers.google.com/admob/ios/ios14#skadnetwork).

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
try {
  // If the system can show an authorization request dialog
  if (await AppTrackingTransparency.trackingAuthorizationStatus ==
      TrackingStatus.notDetermined) {
    // Show a custom explainer dialog before the system dialog
    if (await showCustomTrackingDialog(context)) {
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }
} on PlatformException {
  // Unexpected exception was thrown
}
```

You can also get advertising identifier after authorization. Until a user grants authorization, the UUID returned will be all zeros: 00000000-0000-0000-0000-000000000000. Also note, the advertisingIdentifier will be all zeros in the Simulator, regardless of the tracking authorization status.
```dart
final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
``` 

## Notes
To use this plugin you should compile your project using XCode 12 and run your app on an ios 14 device.

Google (admob) recommends implementing an explainer message that appears to users immediately before the consent dialogue. For additional info on this topic please refer to this article: <https://support.google.com/admob/answer/9997589?hl=en>

## Important Notice

IOS does not allow to display multiple native dialogs. If you try to open a native dialog when there is already a dialog on screen, previous dialog will be forcefully closed by the system. It's very common to show notification permission dialog on the first run of an ios application. If you both try to show a notification permission dialog and app tracking request dialog, one of the each will be cancelled. One way to handle this is using an explainer dialog before requesting tracking authorization. Please check the sample project for more on this. I highly recommend this approach.

Another way to get over this problem is postponing permission request until 2nd, or Nth run of the application. If you choose this way, please make sure that you inform app store reviewer that you postponed tracking request, or your submission may be rejected.

And finally; Always test on a real device with a fresh installed application.
