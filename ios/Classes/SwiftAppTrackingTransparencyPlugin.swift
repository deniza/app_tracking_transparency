import Flutter
import UIKit
import AppTrackingTransparency
import AdSupport

public class SwiftAppTrackingTransparencyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "app_tracking_transparency", binaryMessenger: registrar.messenger())
    let instance = SwiftAppTrackingTransparencyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "getTrackingAuthorizationStatus") {
        getTrackingAuthorizationStatus(result: result)
    }
    else if (call.method == "requestTrackingAuthorization") {
        requestTrackingAuthorization(result: result)
    }
    else if (call.method == "getAdvertisingIdentifier") {
        getAdvertisingIdentifier(result: result)
    }
    else {
        result(FlutterMethodNotImplemented)
    }
  }

  private func getTrackingAuthorizationStatus(result: @escaping FlutterResult) {
    if #available(iOS 14, *) {
        result(Int(ATTrackingManager.trackingAuthorizationStatus.rawValue))
    } else {
        // return notSupported
        result(Int(4))
    }
  }

  /*
    case notDetermined = 0
    case restricted = 1
    case denied = 2
    case authorized = 3
  */
  private func requestTrackingAuthorization(result: @escaping FlutterResult) {
    if #available(iOS 14, *) {
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
            result(Int(status.rawValue))
        })
    } else {
        // return notSupported
        result(Int(4))
    }
  }

  private func getAdvertisingIdentifier(result: @escaping FlutterResult) {
    result(String(ASIdentifierManager.shared().advertisingIdentifier.uuidString))
  }
}
