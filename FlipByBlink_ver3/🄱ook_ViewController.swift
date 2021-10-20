import UIKit
import PDFKit
import ARKit


class 🄱ook_ViewController:UIViewController{
    
    
    @IBOutlet weak var 📖: PDFView!
    
    var 📚:PDFDocument!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        📖.autoScales = true
        📖.displayMode = .singlePage
        📖.displaysPageBreaks = false
        📖.isUserInteractionEnabled = false
        📖.accessibilityElementsHidden = true
        
        📖.document = 📚
        
        if 📚.documentURL?.lastPathComponent == "🄸mported.pdf"{
            if let 🔖 = 📚.page(at: UserDefaults.standard.integer(forKey: "🔖") - 1){
                📖.go(to: 🔖)
            }
        }
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    
    @IBAction func 🄶oToNextPage() {
        if 📖.canGoToNextPage == false{
            let 🗣 = UIAlertController(title: "🎉 Finish!", message: nil, preferredStyle: .alert)
            present(🗣, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){ 🗣.dismiss(animated: true) }
        }
        📖.goToNextPage(nil)
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
        let 💬 = "0 ~ " + (self.📚.pageCount - 1).description
        let 🗣 = UIAlertController(title: 💬, message: nil, preferredStyle: .alert)
        🗣.addTextField { 📋 in
            📋.keyboardType = .numberPad
            📋.placeholder = "Page No."
        }
        🗣.addAction(UIAlertAction(title: "Go!", style: .default){ _ in
            guard let 📝 = Int((🗣.textFields?.first?.text)!) else { return }
            guard let 🔖 = self.📖.document?.page(at: 📝) else { return }
            self.📖.go(to: 🔖)
        })
        🗣.addAction(UIAlertAction(title: "cancel", style: .cancel))
        self.present(🗣, animated: true)
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
            let 🔖 = 📖.currentPage!.pageRef!.pageNumber
            UserDefaults.standard.set(🔖, forKey: "🔖")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if ARFaceTrackingConfiguration.isSupported == false{
            let 💬 = "Your device can't work facetracking. \"Face tracking supports devices with Apple Neural Engine in iOS 14 and iPadOS 14 and requires a device with a TrueDepth camera on iOS 13 and iPadOS 13 and earlier.\" source:https://developer.apple.com/documentation/arkit/arfacetrackingconfiguration"
            let 🗣 = UIAlertController(title: "Sorry 😱", message: 💬, preferredStyle: .alert)
            🗣.addAction(UIAlertAction(title: "OK", style: .default))
            present(🗣, animated: true)
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.📖.sizeToFit()
        }
    }
    
    
}
