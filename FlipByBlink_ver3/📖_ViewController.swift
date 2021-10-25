import UIKit
import PDFKit
import ARKit


class 📖_ViewController:UIViewController, ARSCNViewDelegate, ARSessionDelegate{
    
    
    var 📚:PDFDocument!
    
    
    @IBOutlet weak var 📖: PDFView!{
        didSet{
            📖.autoScales = true
            📖.displayMode = .singlePage
            📖.displaysPageBreaks = false
            📖.isUserInteractionEnabled = false
            📖.accessibilityElementsHidden = true
            
            📖.document = 📚
            
            if 📚.documentURL?.lastPathComponent == "🄸mported.pdf"{
                let 🔖 = UserDefaults.standard.integer(forKey: "🔖")
                📖.go(to: 📚.page(at: 🔖)!)
            }
        }
    }
    
    
    @IBOutlet weak var 🔘: ARSCNView!{
        didSet{
            🔘.delegate = self
            🔘.session.delegate = self
            let 🎛 = ARFaceTrackingConfiguration()
            🔘.session.run(🎛)
            
            🔘.layer.cornerRadius = 🔘.frame.height/2
            🔘.layer.borderWidth = 6
            🔘.layer.borderColor = UIColor.darkGray.cgColor
            🔘.scene.background.contents = UIColor.systemBackground
        }
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 2, delay: 2) {
                self.🔘.alpha = 0
            }
        }
        let 👤 = ARSCNFaceGeometry(device: 🔘.device!)!
        👤.firstMaterial?.diffuse.contents = UIColor.darkGray
        return SCNNode(geometry: 👤)
    }
    
    
    var 🕰😑start: Date = Date()
    var 🕰😑🔛: Date = Date()
    let 🎚😑sec: Double = 0.15
    var ex🌡👀: Double = 0.0
    let 🎚👀: Double = 0.8
    var not🗒yet: Bool = true
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let 🪧 = anchor as? ARFaceAnchor else { return }
        
        guard let 🌡👀left = 🪧.blendShapes[.eyeBlinkLeft]?.doubleValue else { return }
        guard let 🌡👀right = 🪧.blendShapes[.eyeBlinkRight]?.doubleValue else { return }
        let 🌡👀 = ( 🌡👀left + 🌡👀right ) / 2
        
        if 🌡👀 > 🎚👀 && ex🌡👀 < 🎚👀{
            🕰😑start = Date()
        }
        
        if 🌡👀 > 🎚👀{
            🕰😑🔛 = Date()
            if 🕰😑🔛.timeIntervalSince(🕰😑start) > TimeInterval(🎚😑sec){
                if not🗒yet{
                    DispatchQueue.main.async {
                        self.🄶oToNextPage()
                    }
                    not🗒yet = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.not🗒yet = true
                    }
                }
            }
        }
        ex🌡👀 = 🌡👀
        
        guard let 👤 = node.geometry as? ARSCNFaceGeometry else { return }
        👤.update(from: 🪧.geometry)
    }
    
    
    func 🄶oToNextPage() {
        📖.goToNextPage(nil)
        
        if 📖.canGoToNextPage == false{
            let 📢 = UIAlertController(title: "🎉 Finish!", message: nil, preferredStyle: .alert)
            present(📢, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                📢.dismiss(animated: true)
            }
        }
    }
    
    
    @IBAction func 👆゛(_ sender: UITapGestureRecognizer) {
        if sender.location(in: view).x > view.center.x{
            🄶oToNextPage()
        }else{
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
        }else{
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
            📋.placeholder = "Page No."
        }
        📢.addAction(UIAlertAction(title: "Jump", style: .default){ _ in
            guard let 📝 = Int((📢.textFields?.first?.text)!) else { return }
            guard let 🔖 = self.📖.document?.page(at: 📝 - 1 ) else { return }
            self.📖.go(to: 🔖)
        })
        📢.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(📢, animated: true)
    }
    
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if 📚.documentURL?.lastPathComponent == "🄸mported.pdf"{
            let 🔖 = 📖.currentPage!.pageRef!.pageNumber - 1
            UserDefaults.standard.set(🔖, forKey: "🔖")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if ARFaceTrackingConfiguration.isSupported == false{
            let 💬 = "Your device can't work facetracking. \"Face tracking supports devices with Apple Neural Engine in iOS 14 and iPadOS 14 and requires a device with a TrueDepth camera on iOS 13 and iPadOS 13 and earlier.\" source:https://developer.apple.com/documentation/arkit/arfacetrackingconfiguration"
            let 📢 = UIAlertController(title: "Sorry 😱", message: 💬, preferredStyle: .alert)
            📢.addAction(UIAlertAction(title: "OK", style: .default))
            present(📢, animated: true)
        }
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.📖.sizeToFit()
        }
    }
    
    
    @IBOutlet weak var 🏁: UIImageView!{
        didSet{
            if UserDefaults.standard.bool(forKey: "🏁"){
                🏁.isHidden = false
            }
        }
    }
    
    
}
