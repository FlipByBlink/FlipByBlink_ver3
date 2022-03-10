
import UIKit
import PDFKit
import ARKit


class 📖_ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    
    var 📚: PDFDocument!
    
    
    @IBOutlet weak var 📖: PDFView! {
        didSet {
            📖.autoScales = true
            📖.displayMode = .singlePage
            📖.displaysPageBreaks = false
            📖.isUserInteractionEnabled = false
            📖.accessibilityElementsHidden = true
            
            📖.document = 📚
            
            if 📚.documentURL?.lastPathComponent == "🄸mported.pdf" {
                let 🔖 = UserDefaults.standard.integer(forKey: "🔖")
                📖.go(to: 📚.page(at: 🔖)!)
            }
        }
    }
    
    
    @IBOutlet weak var 🔘: ARSCNView! {
        didSet {
            🔘.delegate = self
            🔘.session.delegate = self
            let 🎛 = ARFaceTrackingConfiguration()
            🔘.session.run(🎛)
            
            🔘.layer.cornerRadius = 🔘.frame.height/2
            🔘.layer.borderWidth = 6
            🔘.layer.borderColor = UIColor.separator.cgColor
            
            if UserDefaults.standard.bool(forKey: "👤🧑‍💼 Real Preview") == false {
                🔘.scene.background.contents = UIColor.systemBackground
            }
            
            if UserDefaults.standard.bool(forKey: "👤🚫 Hide Preview") {
                🔘.isHidden = true
            }
        }
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if UserDefaults.standard.bool(forKey: "👤🔁 Always Preview") == false {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 2, delay: 2) {
                    self.🔘.alpha = 0
                }
            }
        }
        
        let 👤 = ARSCNFaceGeometry(device: renderer.device!)!
        👤.firstMaterial?.diffuse.contents = UIColor.systemGray
        
        if UserDefaults.standard.bool(forKey: "👤🧑‍💼 Real Preview") {
            👤.firstMaterial?.diffuse.contents = UIColor.clear
        }
        
        return SCNNode(geometry: 👤)
    }
    
    
    var 🕰😑start = Date()
    
    var 🎚😑second: Double {
        if let 🎚 = UserDefaults.standard.string(forKey: "🎚😑second") {
            return Double(🎚)!
        } else {
            return 0.15
        }
    }
    
    var 🌡👀 = 0.0
    
    var 💤 = false
    
    var 🕰😉start = Date()
    
    var 🌡😉 = 0.0
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let 🪧 = anchor as? ARFaceAnchor else { return }
        guard let 👤 = node.geometry as? ARSCNFaceGeometry else { return }
        👤.update(from: 🪧.geometry)
        
        guard let 🌡👀L = 🪧.blendShapes[.eyeBlinkLeft]?.doubleValue else { return }
        guard let 🌡👀R = 🪧.blendShapes[.eyeBlinkRight]?.doubleValue else { return }
        let New🌡👀 = ( 🌡👀L + 🌡👀R ) / 2
        
        let 🎚👀 = 0.8
        
        if 🌡👀 < 🎚👀 {
            if New🌡👀 > 🎚👀 {
                🕰😑start = Date()
            }
        }
        
        🌡👀 = New🌡👀
        
        if 💤 { return }
        
        if New🌡👀 > 🎚👀 {
            if Date().timeIntervalSince(🕰😑start) > 🎚😑second {
                DispatchQueue.main.async {
                    self.🄶oToNextPage()
                }
                
                💤 = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                    self.💤 = false
                }
            }
        }
        
        
        if UserDefaults.standard.bool(forKey: "😉 return") {
            
            let New🌡😉 = abs( 🌡👀L - 🌡👀R )
            
            let 🎚😉 = 0.5
            
            if 🌡😉 < 🎚😉 {
                if New🌡😉 > 🎚😉 {
                    🕰😉start = Date()
                }
            }
            
            🌡😉 = New🌡😉
            
            if 💤 == false {
                if New🌡😉 > 🎚😉 {
                    if Date().timeIntervalSince(🕰😉start) > 0.5 {
                        DispatchQueue.main.async {
                            self.📖.goToPreviousPage(nil)
                        }
                        
                        💤 = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                            self.💤 = false
                        }
                    }
                }
            }
        }
    }
    
    
    func 🄶oToNextPage() {
        if 📖.canGoToNextPage == false {
            let 💬 = NSLocalizedString("🎉 Finish! 🎉", comment: "")
            let 📢 = UIAlertController(title: 💬, message: nil, preferredStyle: .alert)
            present(📢, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) {
                📢.dismiss(animated: true)
            }
        }
        
        📖.goToNextPage(nil)
    }
    
    
    @IBAction func 👆゛(_ sender: UITapGestureRecognizer) {
        if sender.location(in: view).x > view.center.x {
            🄶oToNextPage()
        } else {
            📖.goToPreviousPage(nil)
        }
    }
    
    
    @IBAction func 👆三三(_ sender: Any) {
        🄶oToNextPage()
    }
    
    
    @IBAction func 三三👆(_ sender: Any) {
        📖.goToPreviousPage(nil)
    }
    
    
    @IBAction func 氵👌(_ sender: UIPinchGestureRecognizer) {
        if sender.velocity > 0 {
            📖.goToNextPage(nil)
        } else {
            📖.goToPreviousPage(nil)
        }
    }
    
    
    @IBAction func ミ👆彡(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func 彡👆ミ(_ sender: Any) {
        let 💬 = "1 〜 " + 📚.pageCount.description
        let 📢 = UIAlertController(title: 💬, message: nil, preferredStyle: .alert)
        
        📢.addTextField { 📋 in
            📋.keyboardType = .numberPad
            let 🔖 = self.📖.currentPage!.pageRef!.pageNumber.description
            📋.placeholder = NSLocalizedString(🔖, comment: "")
        }
        
        let 🆗 = NSLocalizedString("Jump", comment: "")
        📢.addAction(UIAlertAction(title: 🆗, style: .default) { _ in
            guard let 📝 = Int((📢.textFields?.first?.text)!) else { return }
            guard let 🔖 = self.📖.document?.page(at: 📝 - 1 ) else { return }
            self.📖.go(to: 🔖)
        })
        
        let 🆖 = NSLocalizedString("Cancel", comment: "")
        📢.addAction(UIAlertAction(title: 🆖, style: .cancel))
        
        self.present(📢, animated: true)
    }
    
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if 📚.documentURL?.lastPathComponent == "🄸mported.pdf" {
            let 🔖 = 📖.currentPage!.pageRef!.pageNumber - 1
            UserDefaults.standard.set(🔖, forKey: "🔖")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if ARFaceTrackingConfiguration.isSupported == false {
            let 😱 = NSLocalizedString("😱 Sorry 😱", comment: "")
            let 💬 = NSLocalizedString("can't work", comment: "")
            let 📢 = UIAlertController(title: 😱, message: 💬, preferredStyle: .alert)
            let 🆗 = NSLocalizedString("OK", comment: "")
            📢.addAction(UIAlertAction(title: 🆗, style: .default))
            present(📢, animated: true)
        }
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
            self.📖.sizeToFit()
        }
    }
    
    
    @IBOutlet weak var 🏁: UIImageView! {
        didSet {
            if UserDefaults.standard.bool(forKey: "🏁 Display share-info") {
                🏁.isHidden = false
            }
        }
    }
    
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)
        
        for 🄿ress in presses {
            switch 🄿ress.key?.keyCode {
            case .keyboardRightArrow: 🄶oToNextPage()
            case .keyboardDownArrow: 🅂kip5Page()
            case .keyboardLeftArrow: 📖.goToPreviousPage(nil)
            case .keyboardUpArrow: 🄱ack5Page()
                
            case .keyboardD: 🄶oToNextPage()
            case .keyboardS: 🅂kip5Page()
            case .keyboardA: 📖.goToPreviousPage(nil)
            case .keyboardW: 🄱ack5Page()
                
            case .keyboardPageDown: 🄶oToNextPage()
            case .keyboardPageUp: 📖.goToPreviousPage(nil)
                
            case .keyboardSpacebar:
                if event?.modifierFlags == .shift {
                    📖.goToPreviousPage(nil)
                } else {
                    🄶oToNextPage()
                }
                
            default: print(🄿ress.key.debugDescription)
            }
            
            func 🅂kip5Page() {
                if 📖.canGoToNextPage {
                    for _ in 1...5 {
                        📖.goToNextPage(nil)
                    }
                } else {
                    🄶oToNextPage()
                }
            }
            
            func 🄱ack5Page() {
                for _ in 1...5 {
                    📖.goToPreviousPage(nil)
                }
            }
        }
    }
}

