import UIKit
import AVKit
import PDFKit

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    
    @IBOutlet weak var 📘: UIButton!
    
    var 📚:PDFDocument!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let 📍 = Bundle.main.url(forResource: "🄿reset", withExtension: "pdf")!
        📚 = PDFDocument(url: 📍)!
        
        🅃humbnail()
        
        📘.layer.shadowColor = UIColor.gray.cgColor
        📘.layer.shadowOpacity = 0.8
        📘.layer.shadowRadius = 4
        📘.layer.shadowOffset = .zero
        
        📘.imageView?.contentMode = .scaleAspectFit
    }
    
    
    func 🅃humbnail(){
        let 💾 = FileManager.default
        let 📍 = 💾.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("🄸mported.pdf")
        if 💾.fileExists(atPath: 📍.path){
            📚 = PDFDocument(url: 📍)
        }
        📘.setImage(📚.page(at: 0)?.thumbnail(of: .init(width: 2000, height: 2000), for: .artBox), for: .normal)
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
        guard let 🏷 = UTType(filenameExtension: "pdf") else { return }
        let 🎮 = UIDocumentPickerViewController(forOpeningContentTypes: [🏷], asCopy: true)
        🎮.delegate = self
        self.present(🎮, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        🅂tore(urls.first!)
    }
    
    func 🅂tore(_ 📦:URL){
        let 💾 = FileManager.default
        let 📍 = 💾.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("🄸mported.pdf")
        if 💾.fileExists(atPath: 📍.path){
            try! 💾.removeItem(at: 📍)
        }
        try! 💾.copyItem(at: 📦, to: 📍)
        UserDefaults.standard.set(0, forKey: "🔖")
        🅃humbnail()
    }
    
    
    // 📘 "Open book"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let 🎮 = segue.destination as! 🄱ook_ViewController
        if (segue.identifier == "📘") {
            🎮.📚 = 📚
        }else{
            let 📍 = Bundle.main.url(forResource: "📄", withExtension: "pdf")!
            🎮.📚 = PDFDocument(url: 📍)
        }
    }
    
    
}

