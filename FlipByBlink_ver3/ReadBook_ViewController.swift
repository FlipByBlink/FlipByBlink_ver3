import UIKit
import PDFKit
import ARKit

class ReadBook_ViewController:UIViewController{
    
    @IBOutlet weak var 📖: PDFView!
    
    var 🏷:String = "📰"
    
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
            if let 📘 = PDFDocument(url: 📍) {
                📖.document = 📘
            }
        case "📗":
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
        📖.goToNextPage(nil)
    }
    
    @objc func 🗒🔙(){
        📖.goToPreviousPage(nil)
    }
    
}
