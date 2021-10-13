import UIKit
import PDFKit
import ARKit

class ReadBook_ViewController:UIViewController{
    
    @IBOutlet weak var 📖: PDFView!
    
    var 🏷 = "📄"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        📖.autoScales = true
        📖.displayMode = .singlePage
        📖.displaysPageBreaks = false
        📖.isUserInteractionEnabled = false
        📖.accessibilityElementsHidden = true
        
        switch 🏷 {
        case "Imported.pdf":
            let 💾 = FileManager.default
            let 📍 = URL(string: 💾.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString + 🏷)!
            if let 📓 = PDFDocument(url: 📍) {
                📖.document = 📓
            }
        case "🌃":
            if let 📍 = Bundle.main.url(forResource: 🏷, withExtension: "pdf") {
                if let 📓 = PDFDocument(url: 📍) {
                    📖.document = 📓
                }
            }
        default:
            if let 📍 = Bundle.main.url(forResource: 🏷, withExtension: "pdf") {
                if let 📓 = PDFDocument(url: 📍) {
                    📖.document = 📓
                }
            }
        }
        
        let 🔖 = UserDefaults.standard.integer(forKey: "🔖")
        if let a = 📖.document?.page(at: 🔖-1){
            📖.go(to: a)
        }
        
        if ARFaceTrackingConfiguration.isSupported == false{
            let 💬 = UIAlertController(title: "Sorry😱", message: "your device can't work facetracking. \"Face tracking supports devices with Apple Neural Engine in iOS 14 and iPadOS 14 and requires a device with a TrueDepth camera on iOS 13 and iPadOS 13 and earlier.\" source:https://developer.apple.com/documentation/arkit/arfacetrackingconfiguration", preferredStyle: .alert)
            💬.addAction(UIAlertAction(title: "OK", style: .default))
            present(💬, animated: true)
        }
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    @IBAction func nextPage(_ sender: Any) {
        🗒()
    }
    
    @IBAction func previousPage(_ sender: Any) {
        🗒🔙()
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        📖.autoScales = true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @objc func 🗒(){
        if 📖.canGoToNextPage == false{
            let 💬 = UIAlertController(title: "🎉 Finish!", message: nil, preferredStyle: .alert)
            present(💬, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){ 💬.dismiss(animated: true) }
        }
        📖.goToNextPage(nil)
    }
    
    @objc func 🗒🔙(){
        📖.goToPreviousPage(nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(📖.currentPage!.pageRef!.pageNumber, forKey: "🔖")
    }
    
}
