import UIKit
import PDFKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let _ = (scene as? UIWindowScene) else { return }
//    }
//
//    func sceneDidDisconnect(_ scene: UIScene) {
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//    }
//
//    func sceneWillEnterForeground(_ scene: UIScene) {
//    }
//
//    func sceneDidEnterBackground(_ scene: UIScene) {
//    }
//    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        if let 🎮:ViewController = window?.rootViewController as? ViewController{
            🎮.📘𝚜𝚝𝚘𝚛𝚎(URLContexts.first!.url)
        }
    }


}

