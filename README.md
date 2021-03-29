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

Google recommends that you should be using Google Mobile Ads SDK 7.64.0 or higher. The Google Mobile Ads SDK supports conversion tracking using Apple's SKAdNetwork, which means Google is able to attribute an app install even when IDFA is unavailable. To enable this functionality, you will need to update the SKAdNetworkItems key with an additional dictionary in your Info.plist. [more info](https://developers.google.com/admob/ios/ios14#skadnetwork)

```xml
<key>SKAdNetworkItems</key>
  <array>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>cstr6suwn9.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>4fzdc2evr5.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>4pfyvq9l8r.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>2fnua5tdw4.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>ydx93a7ass.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>5a6flpkh64.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>p78axxw29g.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>v72qych5uu.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>ludvb6z3bs.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>c6k4g5qg8m.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>s39g8k73mm.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>3qy4746246.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>3sh42y64q3.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>f38h382jlk.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>hs6bdukanm.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>prcb7njmu6.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>v9wttpbfk9.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>wzmmz9fp6w.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>yclnxrl5pm.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>4468km3ulz.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>t38b2kh725.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>7ug5zh24hu.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>9rd848q2bz.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>n6fk4nfna4.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>kbd757ywx3.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>9t245vhmpl.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>k674qkevps.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>2u9pt9hc89.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>8s468mfl3y.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>av6w8kgt66.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>klf5c3l5u5.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>y2ed4ez56y.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>ppxm28t8ap.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>424m5254lk.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>ecpz2srf59.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>uw77j35x4d.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>e5fvkxwrpn.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>zq492l623r.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>hjevpa356n.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>3qcr597p9d.skadnetwork</string>
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
