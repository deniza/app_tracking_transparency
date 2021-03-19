import 'package:flutter_test/flutter_test.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

// Flutter tests run on desktop (e.g. windows), so Platform.isIOS is always false.
// When the platform isn't iOS, this package's methods return notSupported or "".
// So this test can be useful for android. Because, on android, this package
// shouldn't throw an error, it should always return notSupported/"".
// On iOS, testing only needs to be done manually.

void main() {
  test('trackingAuthorizationStatus', () async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    expect(status, TrackingStatus.notSupported);
  });

  test('requestTrackingAuthorization', () async {
    final status = await AppTrackingTransparency.requestTrackingAuthorization();
    expect(status, TrackingStatus.notSupported);
  });

  test('getAdvertisingIdentifier', () async {
    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    expect(uuid, "");
  });
}
