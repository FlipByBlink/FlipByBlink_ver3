import UIKit
import AVKit
import PDFKit

class ViewController: UIViewController, UIDocumentPickerDelegate {

    @IBOutlet weak var Button_OpenBook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: 📄
    @IBAction func ReadDocument(_ sender: Any) {
    }
    
    //MARK: ▶️
    @IBAction func PlayVideo(_ sender: Any) {
        guard let 📍 = Bundle.main.url(forResource: "VIDEO", withExtension: "mp4") else { return }
        let 🎞 = AVPlayer(url: 📍)
        let 📺 = AVPlayerViewController()
        📺.player = 🎞
        📺.modalTransitionStyle = .partialCurl
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
    @IBAction func SelectBook(_ sender: Any) {
        guard let 📚 = UTType(filenameExtension: "pdf") else { return }
        let 🗃 = UIDocumentPickerViewController(forOpeningContentTypes: [📚], asCopy: true)
        🗃.delegate = self
        self.present(🗃, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let 💾 = FileManager.default
        let 📍 = URL(string: 💾.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString + "SelectedBook.pdf")!
        do{ try 💾.removeItem(at: 📍) } catch { print("🚨") }
        do{ try 💾.copyItem(at: urls.first!, to: 📍) } catch { print("🚨") }
        if let 📓 = PDFDocument(url: 📍) {
            Button_OpenBook.setImage(📓.page(at: 0)?.thumbnail(of: Button_OpenBook.frame.size, for: .artBox), for: .normal)
        }
    }
    
    //MARK: Button_OpenBook
    @IBAction func OpenBook(_ sender: Any) {
    }
    
}

