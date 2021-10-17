import UIKit
import AVKit
import PDFKit

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var 📘: UIButton!
    
    let 🄸mportedBook = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("🄸mported.pdf")
    let 📄 = Bundle.main.url(forResource: "📄", withExtension: "pdf")!
    let 🄿reset = Bundle.main.url(forResource: "🄿reset", withExtension: "pdf")!
    
    let 💾 = FileManager.default
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if 💾.fileExists(atPath: 🄸mportedBook.path) {
            🅃humbnail(🄸mportedBook)
        }else{
            🅃humbnail(🄿reset)
        }
        
        📘.layer.shadowColor = UIColor.gray.cgColor
        📘.layer.shadowOpacity = 0.8
        📘.layer.shadowRadius = 4
        📘.layer.shadowOffset = .zero
    }
    

    @IBAction func ᐅ⃣(_ sender: Any) {
        guard let 📍 = Bundle.main.url(forResource: "▶️", withExtension: "mp4") else { return }
        let 🎮 = AVPlayerViewController()
        let 📺 = AVPlayer(url: 📍)
        🎮.player = 📺
        self.present(🎮, animated: true)
    }
    
    
    // ⚙️
    @IBAction func 🅂etting(_ sender: Any) {
        let 📍 = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(📍)
    }
    
    
    @IBAction func 🄰(_ sender: Any) {
        let 📍 = URL(string: "https://apps.apple.com/jp/app/id1444571751")!
        UIApplication.shared.open(📍)
    }
    
    
    @IBAction func 📁(_ sender: Any) {
        guard let 📚 = UTType(filenameExtension: "pdf") else { return }
        let 🎮 = UIDocumentPickerViewController(forOpeningContentTypes: [📚], asCopy: true)
        🎮.delegate = self
        self.present(🎮, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        🅂tore(urls.first!)
    }
    
    func 🅂tore(_ 📍:URL){
        if 💾.fileExists(atPath: 🄸mportedBook.path){
            do{ try 💾.removeItem(at: 🄸mportedBook) } catch { print("🚨") }
        }
        do{ try 💾.copyItem(at: 📍, to: 🄸mportedBook) } catch { print("🚨") }
        UserDefaults.standard.set(0, forKey: "🔖")
        🅃humbnail(🄸mportedBook)
    }
    
    
    // 📘 OpenBook 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let 🎮 = segue.destination as! 🄱ook_ViewController
        if (segue.identifier == "OpenBookSegue") {
            if 💾.fileExists(atPath: 🄸mportedBook.path) {
                🎮.🏷 = 🄸mportedBook
                🎮.modalPresentationStyle = .fullScreen
            }else{
                🎮.🏷 = 🄿reset
            }
        }else{
            🎮.🏷 = 📄
        }
    }
    
    
    func 🅃humbnail(_ 📍:URL){
        if let 📓 = PDFDocument(url: 📍){
            📘.setImage(📓.page(at: 0)?.thumbnail(of: .init(width: 2000, height: 2000), for: .artBox), for: .normal)
            📘.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    
}

