
import UIKit
import PDFKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let ๐ฎ = window?.rootViewController as? ViewController {
            ๐ฎ.๐tore(URLContexts.first!.url)
        }
    }

    
    //===="Xcode template source code"====
    
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
    
    //====================================
    
    
}

