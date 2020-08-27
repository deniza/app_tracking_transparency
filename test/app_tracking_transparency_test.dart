import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

void main() {
  const MethodChannel channel = MethodChannel('app_tracking_transparency');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'requestTrackingAuthorization':
          return 0;
        case 'getAdvertisingIdentifier':
          return "0";
        default:
          return null;
      }
    });
  });

  test('requestTrackingAuthorization', () async {
    final status = await AppTrackingTransparency.requestTrackingAuthorization();
    expect(status, isNotNull);
  });

  test('getAdvertisingIdentifier', () async {
    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    expect(uuid, isNotNull);
  });
}
