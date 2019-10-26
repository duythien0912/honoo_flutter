import UIKit
import Flutter
import FileProviderUI

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    static let shareChannel = "channel:honoo.share/share"
  override func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let flutterVC = self.window.rootViewController as! FlutterViewController
    
    let flutterMethodChannel = FlutterMethodChannel(name: AppDelegate.shareChannel, binaryMessenger: flutterVC.binaryMessenger)
    
    flutterMethodChannel.setMethodCallHandler { (call, result) in
        guard call.method == "shareFile" else {return}
        self.shareFile(call.arguments, with: flutterVC)
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func shareFile(_ sharedItems: Any?, with controller: UIViewController) {
        let filePath = sharedItems as! String
        let docPath = getDocumentsDirectory().appendingPathComponent(filePath)
        let imageURL = URL(fileURLWithPath: docPath.path)
    
        guard let imageData = try? Data(contentsOf: imageURL) else {return}
        guard let image = UIImage(data: imageData) else {return}
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.present(activityVC, animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
