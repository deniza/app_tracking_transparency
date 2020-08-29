import Flutter
import UIKit
#if canImport(AppTrackingTransparency)
    import AppTrackingTransparency
#endif
import AdSupport;

public class SwiftAppTrackingTransparencyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "app_tracking_transparency", binaryMessenger: registrar.messenger())
    let instance = SwiftAppTrackingTransparencyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    if (call.method == "requestTrackingAuthorization") {
        requestTrackingAuthorization(result: result)
    }
    else if (call.method == "getAdvertisingIdentifier") {
        getAdvertisingIdentifier(result: result)
    }
    else {
        result(FlutterMethodNotImplemented)
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
         #if canImport(AppTrackingTransparency)
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in

            switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("requestTrackingAuthorization: Authorized")
                
                    // Now that we are authorized we can get the IDFA
                    // print(ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("requestTrackingAuthorization: Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("requestTrackingAuthorization: Not Determined")
                case .restricted:
                    print("requestTrackingAuthorization: Restricted")
                @unknown default:
                    print("requestTrackingAuthorization: Unknown")
            }
            
            result(Int(status.rawValue));

        })
        #else
        result(Int(0));
        #endif
    } else {
        // Fallback on earlier versions
        result(Int(0));
    }
        
  }
    
  private func getAdvertisingIdentifier(result: @escaping FlutterResult) {
    result(String(ASIdentifierManager.shared().advertisingIdentifier.uuidString))
  }

}
