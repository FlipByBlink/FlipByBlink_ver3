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
            self.📓pdfBookView.displaysRTL = 🅄serDefaults.isRTL
            self.📓pdfBookView.displayMode = 🅄serDefaults.isTwoPageEnabled ? .twoUp : .singlePage
            self.📓pdfBookView.displaysAsBook = 🅄serDefaults.isFirstPageDisplayedAsSinglePage
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
            
            if 🅄serDefaults.isRealPreviewEnabled == false {
                self.🔘arView.scene.background.contents = UIColor.systemBackground
            }
            
            if 🅄serDefaults.isPreviewHidden {
                self.🔘arView.isHidden = true
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if 🅄serDefaults.isPreviewAlwaysVisible == false {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 2, delay: 2) {
                    self.🔘arView.alpha = 0
                }
            }
        }
        
        let faceGeometry = ARSCNFaceGeometry(device: renderer.device!)!
        faceGeometry.firstMaterial?.diffuse.contents = UIColor.systemGray
        
        if 🅄serDefaults.isRealPreviewEnabled {
            faceGeometry.firstMaterial?.diffuse.contents = UIColor.clear
        }
        
        return SCNNode(geometry: faceGeometry)
    }
    
    private var 🕰😑start = Date.now

    private var 🎚😑second: Double {
        if let ⓢtring = 🅄serDefaults.blinkDurationSecond {
            Double(ⓢtring)!
        } else {
            0.15
        }
    }
    
    private var 🌡👀value = 0.0

    private let 🎚👀threshold = 0.8
    
    private var 💤suspend = false
    
    private var 🕰😉start = Date.now
    
    private var 🌡😉oneEyeValue = 0.0
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let ⓐnchor = anchor as? ARFaceAnchor else { return }
        guard let ⓕaceGeometry = node.geometry as? ARSCNFaceGeometry else { return }
        ⓕaceGeometry.update(from: ⓐnchor.geometry)
        
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
        
        if 🅄serDefaults.isOneEyeBlinkEnabled {
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
        let ⓘsRight = sender.location(in: view).x > view.center.x
        if ⓘsRight {
            if 🅄serDefaults.isRTL {
                self.goToPreviousPage()
            } else {
                self.goToNextPageWithLastPageAlert()
            }
        } else {
            if 🅄serDefaults.isRTL {
                self.goToNextPageWithLastPageAlert()
            } else {
                self.goToPreviousPage()
            }
        }
    }
    
    @IBAction func 👆三三swipeLeft(_ sender: Any) {
        if 🅄serDefaults.isRTL {
            self.goToPreviousPage()
        } else {
            self.goToNextPageWithLastPageAlert()
        }
    }
    
    @IBAction func 三三👆swipeRight(_ sender: Any) {
        if 🅄serDefaults.isRTL {
            self.goToNextPageWithLastPageAlert()
        } else {
            self.goToPreviousPage()
        }
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
        let ⓐlertController = UIAlertController(title: "1 〜 " + self.pageCount.description,
                                                message: nil,
                                                preferredStyle: .alert)
        
        ⓐlertController.addTextField {
            $0.keyboardType = .numberPad
            $0.placeholder = NSLocalizedString(self.currentPageNumber.description, comment: "")
        }
        
        ⓐlertController.addAction(
            UIAlertAction(
                title: NSLocalizedString("Jump", comment: ""),
                style: .default
            ) { _ in
                if let intValue = Int((ⓐlertController.textFields?.first?.text)!) {
                    self.go(to: intValue - 1)
                }
            }
        )
        
        ⓐlertController.addAction(.init(title: NSLocalizedString("Cancel", comment: ""),
                                        style: .cancel))
        
        self.present(ⓐlertController, animated: true)
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
            let alertController = UIAlertController(title: NSLocalizedString("🎉 Finish! 🎉", comment: ""),
                                                    message: nil,
                                                    preferredStyle: .alert)
            self.present(alertController, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) {
                alertController.dismiss(animated: true)
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
                if let ⓟage = self.pdfDocument.page(at: 🅄serDefaults.bookmarkNumber) {
                    self.📓pdfBookView.go(to: ⓟage)
                }
            case .importedZIP:
                self.📓pdfBookView.isHidden = true
                self.📗zipBookView.isHidden = false
                self.📗zipBookView.go(to: 🅄serDefaults.bookmarkNumber)
                self.📗zipBookView.setLayerShadow()
        }
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        switch self.presentedFile {
            case .importedPDF, .importedZIP:
                🅄serDefaults.setBookmarkNumber(self.currentPageNumber - 1)
            default:
                break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ARFaceTrackingConfiguration.isSupported == false {
            let ⓐlertController = UIAlertController(title: NSLocalizedString("😱 Sorry 😱", comment: ""),
                                                    message: NSLocalizedString("can't work", comment: ""),
                                                    preferredStyle: .alert)
            ⓐlertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                                    style: .default))
            self.present(ⓐlertController, animated: true)
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
            if 🅄serDefaults.isShareInfoDisplayed {
                self.🏁imageForShare.isHidden = false
            }
        }
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)
        for ⓟress in presses {
            switch ⓟress.key?.keyCode {
                case .keyboardRightArrow, .keyboardD:
                    if 🅄serDefaults.isRTL {
                        self.goToPreviousPage()
                    } else {
                        self.goToNextPageWithLastPageAlert()
                    }
                case .keyboardDownArrow, .keyboardS:
                    ⓢkip5Page()
                case .keyboardLeftArrow, .keyboardA:
                    if 🅄serDefaults.isRTL {
                        self.goToNextPageWithLastPageAlert()
                    } else {
                        self.goToPreviousPage()
                    }
                case .keyboardUpArrow, .keyboardW:
                    ⓑack5Page()
                    
                case .keyboardPageDown:
                    self.goToNextPageWithLastPageAlert()
                case .keyboardPageUp:
                    self.goToPreviousPage()
                    
                case .keyboardSpacebar:
                    if event?.modifierFlags == .shift {
                        self.goToPreviousPage()
                    } else {
                        self.goToNextPageWithLastPageAlert()
                    }
                    
                default:
                    print(ⓟress.key.debugDescription)
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
