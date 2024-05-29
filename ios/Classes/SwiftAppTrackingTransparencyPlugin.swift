import Flutter
import UIKit
import AppTrackingTransparency
import AdSupport

public class SwiftAppTrackingTransparencyPlugin: NSObject, FlutterPlugin {
  private var observer: NSObjectProtocol?
  
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
         removeObserver()

        ATTrackingManager.requestTrackingAuthorization{ [weak self] status in
            if status == .denied, ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                    print("iOS 17.4 authorization bug detected")
                    self?.addObserver(result: result)
                    return
            }
            result(Int(status.rawValue))
        }
    } else {
        // return notSupported
        result(Int(4))
    }
  }

  private func getAdvertisingIdentifier(result: @escaping FlutterResult) {
    result(String(ASIdentifierManager.shared().advertisingIdentifier.uuidString))
  }

  private func addObserver(result: @escaping FlutterResult) {
    removeObserver()
    observer = NotificationCenter.default.addObserver(
        forName: UIApplication.didBecomeActiveNotification,
        object: nil,
        queue: .main
    ) { [weak self] _ in
        self?.requestTrackingAuthorization(result: result)
    }
  }

  private func removeObserver() {
    if let observer = observer {
        NotificationCenter.default.removeObserver(observer)
        self.observer = nil
    }
  }
}
