
import UIKit
import PDFKit
import ARKit

class 📖ReadingViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    var pdfDocument: PDFDocument = PDFDocument()
    
    var presentedFile: 🄵ile.PresentedFile = .presetPDF
    
    @IBOutlet weak var 📗zipBookView: 📗ZIPBookView!
    
    @IBOutlet weak var 📓pdfBookView: PDFView! {
        didSet {
            self.📓pdfBookView.autoScales = true
            self.📓pdfBookView.displaysPageBreaks = false
            self.📓pdfBookView.isUserInteractionEnabled = false
            self.📓pdfBookView.accessibilityElementsHidden = true
            self.📓pdfBookView.displayMode = UserDefaults.standard.bool(forKey: "📖 Show multi page") ? .twoUp : .singlePage
            self.📓pdfBookView.displaysAsBook = UserDefaults.standard.bool(forKey: "📙 Display the first page as a single page")
            self.📓pdfBookView.document = self.pdfDocument
        }
    }
    
    @IBOutlet weak var 🔘arView: ARSCNView! {
        didSet {
            self.🔘arView.delegate = self
            self.🔘arView.session.delegate = self
            self.🔘arView.session.run(ARFaceTrackingConfiguration())
            
            self.🔘arView.layer.cornerRadius = self.🔘arView.frame.height/2
            self.🔘arView.layer.borderWidth = 6
            self.🔘arView.layer.borderColor = UIColor.separator.cgColor
            
            if UserDefaults.standard.bool(forKey: "👤🧑‍💼 Real Preview") == false {
                self.🔘arView.scene.background.contents = UIColor.systemBackground
            }
            
            if UserDefaults.standard.bool(forKey: "👤🚫 Hide Preview") {
                self.🔘arView.isHidden = true
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if UserDefaults.standard.bool(forKey: "👤🔁 Always Preview") == false {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 2, delay: 2) {
                    self.🔘arView.alpha = 0
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
    
    private var 🌡👀value = 0.0

    private let 🎚👀threshold = 0.8
    
    private var 💤suspend = false
    
    private var 🕰😉start = Date.now
    
    private var 🌡😉oneEyeValue = 0.0
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let ⓐnchor = anchor as? ARFaceAnchor else { return }
        guard let 👤 = node.geometry as? ARSCNFaceGeometry else { return }
        👤.update(from: ⓐnchor.geometry)
        
        guard let 🌡👀valueL = ⓐnchor.blendShapes[.eyeBlinkLeft]?.doubleValue else { return }
        guard let 🌡👀valueR = ⓐnchor.blendShapes[.eyeBlinkRight]?.doubleValue else { return }
        let 🌡👀newValue = ( 🌡👀valueL + 🌡👀valueR ) / 2
        
        if 🌡👀value < 🎚👀threshold {
            if 🌡👀newValue > 🎚👀threshold {
                🕰😑start = Date.now
            }
        }
        
        🌡👀value = 🌡👀newValue
        
        if 💤suspend { return }
        
        if 🌡👀newValue > 🎚👀threshold {
            if Date.now.timeIntervalSince(🕰😑start) > 🎚😑second {
                DispatchQueue.main.async {
                    self.goToNextPageWithLastPageAlert()
                }
                
                💤suspend = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                    self.💤suspend = false
                }
            }
        }
        
        if UserDefaults.standard.bool(forKey: "😉 return") {
            let 🌡😉newOneEyeValue = abs( 🌡👀valueL - 🌡👀valueR )
            
            let 🎚😉oneEyeThreshold = 0.5
            
            if 🌡😉oneEyeValue < 🎚😉oneEyeThreshold {
                if 🌡😉newOneEyeValue > 🎚😉oneEyeThreshold {
                    🕰😉start = Date.now
                    🕰😉start = Date.now
                }
            }
            
            🌡😉oneEyeValue = 🌡😉newOneEyeValue
            
            if 💤suspend == false {
                if 🌡😉newOneEyeValue > 🎚😉oneEyeThreshold {
                    if Date.now.timeIntervalSince(🕰😉start) > 0.5 {
                        DispatchQueue.main.async {
                            self.goToPreviousPage()
                        }
                        
                        💤suspend = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                            self.💤suspend = false
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func 👆゛tap(_ sender: UITapGestureRecognizer) {
        if sender.location(in: view).x > view.center.x {
            self.goToNextPageWithLastPageAlert()
        } else {
            self.goToPreviousPage()
        }
    }
    
    @IBAction func 👆三三swipeLeft(_ sender: Any) {
        self.goToNextPageWithLastPageAlert()
    }
    
    @IBAction func 三三👆swipeRight(_ sender: Any) {
        self.goToPreviousPage()
    }
    
    @IBAction func 氵👌pinch(_ sender: UIPinchGestureRecognizer) {
        if sender.velocity > 0 {
            self.goToNextPage()
        } else {
            self.goToPreviousPage()
        }
    }
    
    @IBAction func ミ👆彡swipeDown(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func 彡👆ミswipeUp(_ sender: Any) {
        let 📢 = UIAlertController(title: "1 〜 " + self.pageCount.description,
                                   message: nil,
                                   preferredStyle: .alert)
        
        📢.addTextField { 📋 in
            📋.keyboardType = .numberPad
            let 🔖 = self.currentPageNumber.description
            📋.placeholder = NSLocalizedString(🔖, comment: "")
        }
        
        let 🆗 = NSLocalizedString("Jump", comment: "")
        📢.addAction(UIAlertAction(title: 🆗, style: .default) { _ in
            if let 📝 = Int((📢.textFields?.first?.text)!) {
                self.go(to: 📝 - 1)
            }
        })
        
        let 🆖 = NSLocalizedString("Cancel", comment: "")
        📢.addAction(UIAlertAction(title: 🆖, style: .cancel))
        
        self.present(📢, animated: true)
    }
    
    private var canGoToNextPage: Bool {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                return self.📓pdfBookView.canGoToNextPage
            case .importedZIP:
                return self.📗zipBookView.canGoToNextPage()
        }
    }
    
    private func goToNextPage() {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                self.📓pdfBookView.goToNextPage(nil)
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
                self.📓pdfBookView.goToPreviousPage(nil)
            case .importedZIP:
                self.📗zipBookView.goToPreviousPage()
        }
    }
    
    private var pageCount: Int {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                return self.pdfDocument.pageCount
            case .importedZIP:
                return self.📗zipBookView.pageCount
        }
    }
    
    private var currentPageNumber: Int {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                return self.📓pdfBookView.currentPage!.pageRef!.pageNumber
            case .importedZIP:
                return self.📗zipBookView.representedCurrentPageNumber
        }
    }
    
    private func go(to ⓟageNumber: Int) {
        switch self.presentedFile {
            case .presetPDF, .appDocumentPDF, .importedPDF:
                if let ⓟage = self.pdfDocument.page(at: ⓟageNumber) {
                    self.📓pdfBookView.go(to: ⓟage)
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
                self.📓pdfBookView.isHidden = false
                self.📗zipBookView.isHidden = true
            case .importedPDF:
                self.📓pdfBookView.isHidden = false
                self.📗zipBookView.isHidden = true
                let 🔖 = UserDefaults.standard.integer(forKey: "🔖")
                if let ⓟage = pdfDocument.page(at: 🔖) {
                    self.📓pdfBookView.go(to: ⓟage)
                }
            case .importedZIP:
                self.📓pdfBookView.isHidden = true
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
            self.📓pdfBookView.sizeToFit()
        }
    }
    
    @IBOutlet weak var 🏁imageForShare: UIImageView! {
        didSet {
            if UserDefaults.standard.bool(forKey: "🏁 Display share-info") {
                self.🏁imageForShare.isHidden = false
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
