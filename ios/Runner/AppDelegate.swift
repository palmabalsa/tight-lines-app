import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey(Bundle.main.object(forInfoDictionaryKey: "G_MAPS_KEY_IOS_FB") as? String ?? "")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
