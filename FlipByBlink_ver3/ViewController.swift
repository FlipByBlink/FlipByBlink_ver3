import UIKit
import AVKit
import PDFKit

class ViewController: UIViewController, UIDocumentPickerDelegate {

    @IBOutlet weak var 📔: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let 💾 = FileManager.default
        let 📍 = URL(string: 💾.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString + "Imported.pdf")!
        if PDFDocument(url: 📍) == nil {
            Set(🖼: Bundle.main.url(forResource: "🌃", withExtension: "pdf")!)
        }else{
            Set(🖼: 📍)
        }
        
        📔.layer.shadowColor = UIColor.gray.cgColor
        📔.layer.shadowOpacity = 0.8
        📔.layer.shadowRadius = 4
        📔.layer.shadowOffset = .zero
    }
    
    
    // ▶️
    @IBAction func PlayVideo(_ sender: Any) {
        guard let 📍 = Bundle.main.url(forResource: "▶️", withExtension: "mp4") else { return }
        let 🎞 = AVPlayer(url: 📍)
        let 📺 = AVPlayerViewController()
        📺.player = 🎞
        self.present(📺, animated: true)
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
        let 🗃 = UIDocumentPickerViewController(forOpeningContentTypes: [📚], asCopy: true)
        🗃.delegate = self
        self.present(🗃, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let 💾 = FileManager.default
        let 📍 = URL(string: 💾.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString + "Imported.pdf")!
        do{ try 💾.removeItem(at: 📍) } catch { print("🚨") }
        do{ try 💾.copyItem(at: urls.first!, to: 📍) } catch { print("🚨") }
        Set(🖼: 📍)
    }
    
    
    // 📄 , OpenBook
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "OpenBookSegue") {
            let 🎮:ReadBook_ViewController = segue.destination as! ReadBook_ViewController
            let 💾 = FileManager.default
            let 📍 = URL(string: 💾.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString + "Imported.pdf")!
            if PDFDocument(url: 📍) == nil {
                🎮.🏷 = "🌃"
            }else{
                🎮.🏷 = "Imported.pdf"
            }
        }
    }
    
    
    func Set(🖼:URL){
        if let 📓 = PDFDocument(url: 🖼){
            📔.setImage(📓.page(at: 0)?.thumbnail(of: .init(width: 2000, height: 2000), for: .artBox), for: .normal)
            📔.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    
}

