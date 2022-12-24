
import UIKit
import PDFKit
import ARKit

class 📖_ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    var 📚: PDFDocument = PDFDocument()
    
    var ⓟresentedFile: 🄵ile.PresentedFile = .presetPDF
    
    @IBOutlet weak var 📗zipBookView: 📗ZIPBookView!
    
    @IBOutlet weak var 📖: PDFView! {
        didSet {
            self.📖.autoScales = true
            self.📖.displayMode = .singlePage
            self.📖.displaysPageBreaks = false
            self.📖.isUserInteractionEnabled = false
            self.📖.accessibilityElementsHidden = true
            
            self.📖.document = self.📚
        }
    }
    
    
    @IBOutlet weak var 🔘: ARSCNView! {
        didSet {
            self.🔘.delegate = self
            self.🔘.session.delegate = self
            let 🎛 = ARFaceTrackingConfiguration()
            self.🔘.session.run(🎛)
            
            self.🔘.layer.cornerRadius = self.🔘.frame.height/2
            self.🔘.layer.borderWidth = 6
            self.🔘.layer.borderColor = UIColor.separator.cgColor
            
            if UserDefaults.standard.bool(forKey: "👤🧑‍💼 Real Preview") == false {
                self.🔘.scene.background.contents = UIColor.systemBackground
            }
            
            if UserDefaults.standard.bool(forKey: "👤🚫 Hide Preview") {
                self.🔘.isHidden = true
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
                    self.ⓖoToNextPageWithLastPageAlert()
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
                            self.ⓖoToPreviousPage()
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
    
    
    @IBAction func 👆゛(_ sender: UITapGestureRecognizer) {
        if sender.location(in: view).x > view.center.x {
            self.ⓖoToNextPageWithLastPageAlert()
        } else {
            self.ⓖoToPreviousPage()
        }
    }
    
    
    @IBAction func 👆三三(_ sender: Any) {
        self.ⓖoToNextPageWithLastPageAlert()
    }
    
    
    @IBAction func 三三👆(_ sender: Any) {
        self.ⓖoToPreviousPage()
    }
    
    
    @IBAction func 氵👌(_ sender: UIPinchGestureRecognizer) {
        if sender.velocity > 0 {
            self.ⓖoToNextPage()
        } else {
            self.ⓖoToPreviousPage()
        }
    }
    
    
    @IBAction func ミ👆彡(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func 彡👆ミ(_ sender: Any) {
        let 💬 = "1 〜 " + self.ⓟageCount.description
        let 📢 = UIAlertController(title: 💬, message: nil, preferredStyle: .alert)
        
        📢.addTextField { 📋 in
            📋.keyboardType = .numberPad
            let 🔖 = self.ⓒurrentPageNumber.description
            📋.placeholder = NSLocalizedString(🔖, comment: "")
        }
        
        let 🆗 = NSLocalizedString("Jump", comment: "")
        📢.addAction(UIAlertAction(title: 🆗, style: .default) { _ in
            guard let 📝 = Int((📢.textFields?.first?.text)!) else { return }
            self.ⓖo(to: 📝 - 1)
        })
        
        let 🆖 = NSLocalizedString("Cancel", comment: "")
        📢.addAction(UIAlertAction(title: 🆖, style: .cancel))
        
        self.present(📢, animated: true)
    }
    
    
    var ⓒanGoToNextPage: Bool {
        switch self.ⓟresentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                return self.📖.canGoToNextPage
            case .importedZIP:
                return self.📗zipBookView.canGoToNextPage()
        }
    }
    
    func ⓖoToNextPage() {
        switch self.ⓟresentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                self.📖.goToNextPage(nil)
            case .importedZIP:
                self.📗zipBookView.goToNextPage()
        }
    }
    
    func ⓖoToNextPageWithLastPageAlert() {
        if self.ⓒanGoToNextPage == false {
            let 💬 = NSLocalizedString("🎉 Finish! 🎉", comment: "")
            let 📢 = UIAlertController(title: 💬, message: nil, preferredStyle: .alert)
            present(📢, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) {
                📢.dismiss(animated: true)
            }
        } else {
            self.ⓖoToNextPage()
        }
    }
    
    func ⓖoToPreviousPage() {
        switch self.ⓟresentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                self.📖.goToPreviousPage(nil)
            case .importedZIP:
                self.📗zipBookView.goToPreviousPage()
        }
    }
    
    var ⓟageCount: Int {
        switch self.ⓟresentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                return self.📚.pageCount
            case .importedZIP:
                return self.📗zipBookView.pageCount
        }
    }
    
    var ⓒurrentPageNumber: Int {
        switch self.ⓟresentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                return self.📖.currentPage!.pageRef!.pageNumber
            case .importedZIP:
                return self.📗zipBookView.representedCurrentPageNumber
        }
    }
    
    func ⓖo(to ⓟageNumber: Int) {
        switch self.ⓟresentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                if let ⓟage = self.📚.page(at: ⓟageNumber) {
                    self.📖.go(to: ⓟage)
                }
            case .importedZIP:
                self.📗zipBookView.go(to: ⓟageNumber)
        }
    }
    
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch self.ⓟresentedFile {
            case .presetPDF, .appDocumentPDF:
                self.📖.isHidden = false
                self.📗zipBookView.isHidden = true
            case .importedPDF:
                self.📖.isHidden = false
                self.📗zipBookView.isHidden = true
                let 🔖 = UserDefaults.standard.integer(forKey: "🔖")
                if let ⓟage = 📚.page(at: 🔖) {
                    self.📖.go(to: ⓟage)
                }
            case .importedZIP:
                self.📖.isHidden = true
                self.📗zipBookView.isHidden = false
                let 🔖 = UserDefaults.standard.integer(forKey: "🔖")
                self.📗zipBookView.go(to: 🔖)
                self.📗zipBookView.setLayerShadow()
        }
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        switch self.ⓟresentedFile {
            case .importedPDF, .importedZIP:
                let 🔖 = self.ⓒurrentPageNumber - 1
                UserDefaults.standard.set(🔖, forKey: "🔖")
            default:
                break
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
                self.🏁.isHidden = false
            }
        }
    }
    
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)
        
        for ⓟress in presses {
            switch ⓟress.key?.keyCode {
                case .keyboardRightArrow: self.ⓖoToNextPageWithLastPageAlert()
                case .keyboardDownArrow: ⓢkip5Page()
                case .keyboardLeftArrow: self.ⓖoToPreviousPage()
                case .keyboardUpArrow: ⓑack5Page()
                    
                case .keyboardD: self.ⓖoToNextPageWithLastPageAlert()
                case .keyboardS: ⓢkip5Page()
                case .keyboardA: self.ⓖoToPreviousPage()
                case .keyboardW: ⓑack5Page()
                    
                case .keyboardPageDown: self.ⓖoToNextPageWithLastPageAlert()
                case .keyboardPageUp: self.ⓖoToPreviousPage()
                    
                case .keyboardSpacebar:
                    if event?.modifierFlags == .shift {
                        self.ⓖoToPreviousPage()
                    } else {
                        self.ⓖoToNextPageWithLastPageAlert()
                    }
                    
                default: print(ⓟress.key.debugDescription)
            }
            
            func ⓢkip5Page() {
                for _ in 1...5 {
                    self.ⓖoToNextPageWithLastPageAlert()
                }
            }
            
            func ⓑack5Page() {
                for _ in 1...5 {
                    self.ⓖoToPreviousPage()
                }
            }
        }
    }
}

