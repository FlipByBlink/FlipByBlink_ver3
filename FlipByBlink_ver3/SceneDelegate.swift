import UIKit
import PDFKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let 💾 = FileManager.default
        let 📍 = URL(string: 💾.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString + "Imported.pdf")!
        do{ try 💾.removeItem(at: 📍) } catch { print("🚨") }
        do{ try 💾.copyItem(at: URLContexts.first!.url, to: 📍) } catch { print("🚨") }
        
        UserDefaults.standard.set(0, forKey: "🔖")
        
        if let 🎮:ViewController = window?.rootViewController as? ViewController{
            🎮.Set(🖼: 📍)
        }
    }


}

