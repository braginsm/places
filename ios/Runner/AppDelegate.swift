import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    YMKMapKit.setApiKey("dbffa052-8890-4d2c-bbb8-9732fbe5f6b9")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
