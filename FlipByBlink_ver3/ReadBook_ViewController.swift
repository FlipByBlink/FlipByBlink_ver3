import UIKit
import PDFKit
import ARKit

class ReadBook_ViewController:UIViewController{
    
    @IBOutlet weak var 📖: PDFView!
    
    var 🏷:URL!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        📖.autoScales = true
        📖.displayMode = .singlePage
        📖.displaysPageBreaks = false
        📖.isUserInteractionEnabled = false
        📖.accessibilityElementsHidden = true
        
        if let 📓 = PDFDocument(url: 🏷) {
            📖.document = 📓
            if 🏷.lastPathComponent == "I⃣mported.pdf"{
                if let 🔖 = 📓.page(at: UserDefaults.standard.integer(forKey: "🔖") - 1){
                    📖.go(to: 🔖)
                }
            }
        }
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    @IBAction func G⃣oToNextPage() {
        if 📖.canGoToNextPage == false{
            let 💬 = UIAlertController(title: "🎉 Finish!", message: nil, preferredStyle: .alert)
            present(💬, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){ 💬.dismiss(animated: true) }
        }
        📖.goToNextPage(nil)
    }
    
    
    @IBAction func G⃣oToPreviousPage() {
        📖.goToPreviousPage(nil)
    }
    
    @IBAction func T⃣ap(_ sender: UITapGestureRecognizer) {
        if sender.location(in: view).x > view.center.x{
            G⃣oToNextPage()
        }else{
            G⃣oToPreviousPage()
        }
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if 🏷.lastPathComponent == "I⃣mported.pdf"{
            UserDefaults.standard.set(📖.currentPage!.pageRef!.pageNumber, forKey: "🔖")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if ARFaceTrackingConfiguration.isSupported == false{
            let 💬 = UIAlertController(title: "Sorry 😱", message: "your device can't work facetracking. \"Face tracking supports devices with Apple Neural Engine in iOS 14 and iPadOS 14 and requires a device with a TrueDepth camera on iOS 13 and iPadOS 13 and earlier.\" source:https://developer.apple.com/documentation/arkit/arfacetrackingconfiguration", preferredStyle: .alert)
            💬.addAction(UIAlertAction(title: "OK", style: .default))
            present(💬, animated: true)
        }
    }
    
}
