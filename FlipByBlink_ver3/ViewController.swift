import UIKit
import AVKit
import PDFKit

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var 📘: UIButton!
    
    let 📘ᵁᴿᴸ = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("𝙄𝙢𝙥𝙤𝙧𝙩𝙚𝙙.pdf")
    let 📄ᵁᴿᴸ = Bundle.main.url(forResource: "📄", withExtension: "pdf")!
    let 🌃ᵁᴿᴸ = Bundle.main.url(forResource: "🌃", withExtension: "pdf")!
    
    let 💾 = FileManager.default
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if 💾.fileExists(atPath: 📘ᵁᴿᴸ.path) {
            📘ᵀᴴᵁᴹᴮᴺᴬᴵᴸ(📘ᵁᴿᴸ)
        }else{
            📘ᵀᴴᵁᴹᴮᴺᴬᴵᴸ(🌃ᵁᴿᴸ)
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
        📘𝚜𝚝𝚘𝚛𝚎(urls.first!)
    }
    
    func 📘𝚜𝚝𝚘𝚛𝚎(_ 📍:URL){
        if 💾.fileExists(atPath: 📘ᵁᴿᴸ.path){
            do{ try 💾.removeItem(at: 📘ᵁᴿᴸ) } catch { print("🚨") }
        }
        do{ try 💾.copyItem(at: 📍, to: 📘ᵁᴿᴸ) } catch { print("🚨") }
        UserDefaults.standard.set(0, forKey: "🔖")
        📘ᵀᴴᵁᴹᴮᴺᴬᴵᴸ(📘ᵁᴿᴸ)
    }
    
    
    // 📘 OpenBook 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let 🎮:ReadBook_ViewController = segue.destination as! ReadBook_ViewController
        if (segue.identifier == "OpenBookSegue") {
            if 💾.fileExists(atPath: 📘ᵁᴿᴸ.path) {
                🎮.🏷 = 📘ᵁᴿᴸ
                🎮.modalPresentationStyle = .fullScreen
            }else{
                🎮.🏷 = 🌃ᵁᴿᴸ
            }
        }else{
            🎮.🏷 = 📄ᵁᴿᴸ
        }
    }
    
    
    func 📘ᵀᴴᵁᴹᴮᴺᴬᴵᴸ(_ 📍:URL){
        if let 📓 = PDFDocument(url: 📍){
            📘.setImage(📓.page(at: 0)?.thumbnail(of: .init(width: 2000, height: 2000), for: .artBox), for: .normal)
            📘.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    
}

