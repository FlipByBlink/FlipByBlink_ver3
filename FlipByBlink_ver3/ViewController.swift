import UIKit
import AVKit
import PDFKit

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var 📘: UIButton!
    
    let 📘url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("𝗜𝗺𝗽𝗼𝗿𝘁𝗲𝗱.pdf")
    let 📄url = Bundle.main.url(forResource: "📄", withExtension: "pdf")!
    let 🌃url = Bundle.main.url(forResource: "🌃", withExtension: "pdf")!
    
    let 💾 = FileManager.default
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if 💾.fileExists(atPath: 📘url.path) {
            T⃣humbnail(📘url)
        }else{
            T⃣humbnail(🌃url)
        }
        
        📘.layer.shadowColor = UIColor.gray.cgColor
        📘.layer.shadowOpacity = 0.8
        📘.layer.shadowRadius = 4
        📘.layer.shadowOffset = .zero
    }
    
    
    @IBAction func ᐅ⃣(_ sender: Any) {
        guard let 📍 = Bundle.main.url(forResource: "▶️", withExtension: "mp4") else { return }
        let 🎮 = AVPlayerViewController()
        let 🎞 = AVPlayer(url: 📍)
        🎮.player = 🎞
        self.present(🎮, animated: true)
    }
    
    
    // ⚙️
    @IBAction func 𝗝𝘂𝗺𝗽𝗦𝗲𝘁𝘁𝗶𝗻𝗴(_ sender: Any) {
        let 📍 = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(📍)
    }
    
    
    @IBAction func A⃣(_ sender: Any) {
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
        S⃣tore(urls.first!)
    }
    
    func S⃣tore(_ 📍:URL){
        if 💾.fileExists(atPath: 📘url.path){
            do{ try 💾.removeItem(at: 📘url) } catch { print("🚨") }
        }
        do{ try 💾.copyItem(at: 📍, to: 📘url) } catch { print("🚨") }
        UserDefaults.standard.set(0, forKey: "🔖")
        T⃣humbnail(📘url)
    }
    
    
    // 📘 OpenBook 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let 🎮:ReadBook_ViewController = segue.destination as! ReadBook_ViewController
        if (segue.identifier == "OpenBookSegue") {
            if 💾.fileExists(atPath: 📘url.path) {
                🎮.🏷 = 📘url
                🎮.modalPresentationStyle = .fullScreen
            }else{
                🎮.🏷 = 🌃url
            }
        }else{
            🎮.🏷 = 📄url
        }
    }
    
    
    func T⃣humbnail(_ 📍:URL){
        if let 📓 = PDFDocument(url: 📍){
            📘.setImage(📓.page(at: 0)?.thumbnail(of: .init(width: 2000, height: 2000), for: .artBox), for: .normal)
            📘.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    
}

