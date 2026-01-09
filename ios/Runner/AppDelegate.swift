import Flutter
import UIKit

// MARK: - Native Blur View для Flutter PlatformView
/// Обеспечивает настоящий iOS "Liquid Glass" эффект через UIVisualEffectView
final class NativeBlurView: NSObject, FlutterPlatformView {
    
    private let blurView: UIVisualEffectView
    
    init(frame: CGRect, arguments: Any?) {
        // Создаем blur effect с UltraThinMaterial
        let effect = UIBlurEffect(style: .systemUltraThinMaterial)
        blurView = UIVisualEffectView(effect: effect)
        blurView.frame = frame
        blurView.clipsToBounds = true
        
        // Опциональные параметры из Flutter
        if let args = arguments as? [String: Any] {
            if let cornerRadius = args["cornerRadius"] as? CGFloat {
                blurView.layer.cornerRadius = cornerRadius
            } else {
                blurView.layer.cornerRadius = 0
            }
            
            // Поддержка разных стилей blur
            if let style = args["style"] as? String {
                let blurStyle: UIBlurEffect.Style
                switch style {
                case "ultraThin":
                    blurStyle = .systemUltraThinMaterial
                case "thin":
                    blurStyle = .systemThinMaterial
                case "regular":
                    blurStyle = .systemMaterial
                case "thick":
                    blurStyle = .systemThickMaterial
                case "chrome":
                    blurStyle = .systemChromeMaterial
                default:
                    blurStyle = .systemUltraThinMaterial
                }
                blurView.effect = UIBlurEffect(style: blurStyle)
            }
        }
        
        super.init()
    }
    
    func view() -> UIView {
        return blurView
    }
}

// MARK: - Factory для NativeBlurView
final class NativeBlurViewFactory: NSObject, FlutterPlatformViewFactory {
    
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return NativeBlurView(frame: frame, arguments: args)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

// MARK: - AppDelegate
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Регистрация NativeBlurView для Liquid Glass эффекта
    guard let registrar = self.registrar(forPlugin: "NativeBlurViewPlugin") else {
      fatalError("Failed to get registrar for NativeBlurViewPlugin")
    }
    
    let factory = NativeBlurViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "native-blur-view")
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
