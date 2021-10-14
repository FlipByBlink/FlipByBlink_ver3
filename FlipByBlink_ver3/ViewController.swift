import UIKit
import AVKit
import PDFKit

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var 📘: UIButton!
    
    let 📍📘 = URL(string: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString + "Imported.pdf")!
    let 📍📄 = Bundle.main.url(forResource: "📄", withExtension: "pdf")!
    let 📍🌃 = Bundle.main.url(forResource: "🌃", withExtension: "pdf")!
    
    let 💾 = FileManager.default
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if 💾.fileExists(atPath: 📍📘.path) {
            📘thumbnail(📍📘)
        }else{
            📘thumbnail(📍🌃)
        }
        
        📘.layer.shadowColor = UIColor.gray.cgColor
        📘.layer.shadowOpacity = 0.8
        📘.layer.shadowRadius = 4
        📘.layer.shadowOffset = .zero
    }
    
    
    // ▶️
    @IBAction func PlayVideo(_ sender: Any) {
        guard let 📍 = Bundle.main.url(forResource: "▶️", withExtension: "mp4") else { return }
        let 🎮 = AVPlayerViewController()
        let 🎞 = AVPlayer(url: 📍)
        🎮.player = 🎞
        self.present(🎮, animated: true)
    }
    
    
    // ⚙️
    @IBAction func JumpSetting(_ sender: Any) {
        let 📍 = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(📍)
    }
    
    
    // 🄰
    @IBAction func JumpAppStore(_ sender: Any) {
        let 📍 = URL(string: "https://apps.apple.com/jp/app/id1444571751")!
        UIApplication.shared.open(📍)
    }
    
    
    // 📁
    @IBAction func ImportBook(_ sender: Any) {
        guard let 📚 = UTType(filenameExtension: "pdf") else { return }
        let 🎮 = UIDocumentPickerViewController(forOpeningContentTypes: [📚], asCopy: true)
        🎮.delegate = self
        self.present(🎮, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        store📘(urls.first!)
    }
    
    func store📘(_ 📍:URL){
        if 💾.fileExists(atPath: 📍📘.path){
            do{ try 💾.removeItem(at: 📍📘) } catch { print("🚨") }
        }
        do{ try 💾.copyItem(at: 📍, to: 📍📘) } catch { print("🚨") }
        UserDefaults.standard.set(0, forKey: "🔖")
        📘thumbnail(📍📘)
    }
    
    
    // 📘 OpenBook
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let 🎮:ReadBook_ViewController = segue.destination as! ReadBook_ViewController
        if (segue.identifier == "OpenBookSegue") {
            if 💾.fileExists(atPath: 📍📘.path) {
                🎮.🏷 = 📍📘
            }else{
                🎮.🏷 = 📍🌃
            }
        }else{
            🎮.🏷 = 📍📄
        }
    }
    
    
    func 📘thumbnail(_ 📍:URL){
        if let 📓 = PDFDocument(url: 📍){
            📘.setImage(📓.page(at: 0)?.thumbnail(of: .init(width: 2000, height: 2000), for: .artBox), for: .normal)
            📘.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    
}

