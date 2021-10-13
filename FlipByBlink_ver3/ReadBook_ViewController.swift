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
        
        switch 🏷 {
        case "ImportedBook.pdf":
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
    }
    
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
}
