import UIKit
import PDFKit
import ARKit

class ReadBook_ViewController:UIViewController{
    
    @IBOutlet weak var 📖: PDFView!
    
    var 🏷 = "📰"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        📖.autoScales = true
        📖.displayMode = .singlePage
        📖.displaysPageBreaks = false
        📖.isUserInteractionEnabled = false
        
        if let 📍 = Bundle.main.url(forResource: 🏷, withExtension: "pdf") {
            if let 📘 = PDFDocument(url: 📍) {
                📖.document = 📘
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
