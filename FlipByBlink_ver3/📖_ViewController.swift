
import UIKit
import PDFKit
import ARKit

class 📖_ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    var 📚: PDFDocument = PDFDocument()
    
    var presentedFile: 🄵ile.PresentedFile = .presetPDF
    
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
    
    private var 🕰😑start = Date.now

    private var 🎚😑second: Double {
        if let 🎚 = UserDefaults.standard.string(forKey: "🎚😑second") {
            return Double(🎚)!
        } else {
            return 0.15
        }
    }
    
    private var 🌡👀 = 0.0
    
    private var 💤 = false
    
    private var 🕰😉start = Date.now
    
    private var 🌡😉 = 0.0
    
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
                🕰😑start = Date.now
            }
        }
        
        🌡👀 = New🌡👀
        
        if 💤 { return }
        
        if New🌡👀 > 🎚👀 {
            if Date.now.timeIntervalSince(🕰😑start) > 🎚😑second {
                DispatchQueue.main.async {
                    self.goToNextPageWithLastPageAlert()
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
                    🕰😉start = Date.now
                    🕰😉start = Date.now
                }
            }
            
            🌡😉 = New🌡😉
            
            if 💤 == false {
                if New🌡😉 > 🎚😉 {
                    if Date.now.timeIntervalSince(🕰😉start) > 0.5 {
                        DispatchQueue.main.async {
                            self.goToPreviousPage()
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
            self.goToNextPageWithLastPageAlert()
        } else {
            self.goToPreviousPage()
        }
    }
    
    @IBAction func 👆三三(_ sender: Any) {
        self.goToNextPageWithLastPageAlert()
    }
    
    @IBAction func 三三👆(_ sender: Any) {
        self.goToPreviousPage()
    }
    
    @IBAction func 氵👌(_ sender: UIPinchGestureRecognizer) {
        if sender.velocity > 0 {
            self.goToNextPage()
        } else {
            self.goToPreviousPage()
        }
    }
    
    @IBAction func ミ👆彡(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func 彡👆ミ(_ sender: Any) {
        let 💬 = "1 〜 " + self.pageCount.description
        let 📢 = UIAlertController(title: 💬, message: nil, preferredStyle: .alert)
        
        📢.addTextField { 📋 in
            📋.keyboardType = .numberPad
            let 🔖 = self.currentPageNumber.description
            📋.placeholder = NSLocalizedString(🔖, comment: "")
        }
        
        let 🆗 = NSLocalizedString("Jump", comment: "")
        📢.addAction(UIAlertAction(title: 🆗, style: .default) { _ in
            guard let 📝 = Int((📢.textFields?.first?.text)!) else { return }
            self.go(to: 📝 - 1)
        })
        
        let 🆖 = NSLocalizedString("Cancel", comment: "")
        📢.addAction(UIAlertAction(title: 🆖, style: .cancel))
        
        self.present(📢, animated: true)
    }
    
    private var canGoToNextPage: Bool {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                return self.📖.canGoToNextPage
            case .importedZIP:
                return self.📗zipBookView.canGoToNextPage()
        }
    }
    
    private func goToNextPage() {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                self.📖.goToNextPage(nil)
            case .importedZIP:
                self.📗zipBookView.goToNextPage()
        }
    }
    
    private func goToNextPageWithLastPageAlert() {
        if self.canGoToNextPage == false {
            let 💬 = NSLocalizedString("🎉 Finish! 🎉", comment: "")
            let 📢 = UIAlertController(title: 💬, message: nil, preferredStyle: .alert)
            present(📢, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) {
                📢.dismiss(animated: true)
            }
        } else {
            self.goToNextPage()
        }
    }
    
    private func goToPreviousPage() {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                self.📖.goToPreviousPage(nil)
            case .importedZIP:
                self.📗zipBookView.goToPreviousPage()
        }
    }
    
    private var pageCount: Int {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                return self.📚.pageCount
            case .importedZIP:
                return self.📗zipBookView.pageCount
        }
    }
    
    private var currentPageNumber: Int {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                return self.📖.currentPage!.pageRef!.pageNumber
            case .importedZIP:
                return self.📗zipBookView.representedCurrentPageNumber
        }
    }
    
    private func go(to ⓟageNumber: Int) {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                if let ⓟage = self.📚.page(at: ⓟageNumber) {
                    self.📖.go(to: ⓟage)
                }
            case .importedZIP:
                self.📗zipBookView.go(to: ⓟageNumber)
        }
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool { true }
    
    override var prefersStatusBarHidden: Bool { true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch self.presentedFile {
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
        switch self.presentedFile {
            case .importedPDF, .importedZIP:
                let 🔖 = self.currentPageNumber - 1
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
                case .keyboardRightArrow: self.goToNextPageWithLastPageAlert()
                case .keyboardDownArrow: ⓢkip5Page()
                case .keyboardLeftArrow: self.goToPreviousPage()
                case .keyboardUpArrow: ⓑack5Page()
                    
                case .keyboardD: self.goToNextPageWithLastPageAlert()
                case .keyboardS: ⓢkip5Page()
                case .keyboardA: self.goToPreviousPage()
                case .keyboardW: ⓑack5Page()
                    
                case .keyboardPageDown: self.goToNextPageWithLastPageAlert()
                case .keyboardPageUp: self.goToPreviousPage()
                    
                case .keyboardSpacebar:
                    if event?.modifierFlags == .shift {
                        self.goToPreviousPage()
                    } else {
                        self.goToNextPageWithLastPageAlert()
                    }
                    
                default: print(ⓟress.key.debugDescription)
            }
            
            func ⓢkip5Page() {
                for _ in 1...5 {
                    self.goToNextPageWithLastPageAlert()
                }
            }
            
            func ⓑack5Page() {
                for _ in 1...5 {
                    self.goToPreviousPage()
                }
            }
        }
    }
}
