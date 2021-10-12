import UIKit
import AVKit
import PDFKit

class ViewController: UIViewController, UIDocumentPickerDelegate {

    //MARK: 📄
    @IBAction func ReadDocument(_ sender: Any) {
        
        //TODO: code
        
    }
    
    //MARK: ▶️
    @IBAction func PlayVideo(_ sender: Any) {
        guard let 📍 = Bundle.main.url(forResource: "📼", withExtension: "mp4") else { return }
        let 🎞 = AVPlayer(url: 📍)
        let 📺 = AVPlayerViewController()
        📺.player = 🎞
        self.present(📺, animated: true)
    }
    
    //MARK: ⚙️
    @IBAction func JumpSetting(_ sender: Any) {
        let 📍 = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(📍)
    }
    
    //MARK: 🄰
    @IBAction func JumpAppStore(_ sender: Any) {
        let 📍 = URL(string: "https://apps.apple.com/jp/app/id1444571751")!
        UIApplication.shared.open(📍)
    }
    
    //MARK: 📁
    @IBAction func ImportBook(_ sender: Any) {
        guard let 📚 = UTType(filenameExtension: "pdf") else { return }
        let 🗃 = UIDocumentPickerViewController(forOpeningContentTypes: [📚], asCopy: true)
        🗃.delegate = self
        self.present(🗃, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let 💾 = FileManager.default
        let 📍 = URL(string: 💾.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString + "ImportedBook.pdf")!
        do{ try 💾.removeItem(at: 📍) } catch { print("🚨") }
        do{ try 💾.copyItem(at: urls.first!, to: 📍) } catch { print("🚨") }
        if let 📓 = PDFDocument(url: 📍) {
            📖.setImage(📓.page(at: 0)?.thumbnail(of: .init(width: 2000, height: 2000), for: .artBox), for: .normal)
            📖.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    //MARK: OpenBook
    @IBOutlet weak var 📖: UIButton!
    
    @IBAction func OpenBook(_ sender: Any) {
        
        //TODO: code
        
    }
    
}

