
import UIKit
import AVKit
import PDFKit
import ARKit


class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    
    @IBOutlet weak var 📘: UIButton! {
        didSet {
            📘.layer.shadowColor = UIColor.gray.cgColor
            📘.layer.shadowOpacity = 0.8
            📘.layer.shadowRadius = 4
            📘.layer.shadowOffset = .zero
            📘.imageView?.contentMode = .scaleAspectFit
            
            let 💾 = FileManager.default
            var 📍 = 💾.urls(for: .documentDirectory, in: .userDomainMask)[0]
            📍.appendPathComponent("🄸mported.pdf")
            if 💾.fileExists(atPath: 📍.path){
                📚 = PDFDocument(url: 📍)
            } else {
                📚 = PDFDocument(data: NSDataAsset(name: "🄿reset")!.data)
            }
        }
    }
    
    
    var 📚: PDFDocument! {
        didSet {
            let 📐 = CGSize(width: 2000, height: 2000)
            let 🖼 = 📚.page(at: 0)?.thumbnail(of: 📐, for: .mediaBox)
            📘.setImage(🖼, for: .normal)
        }
    }
    
    
    @IBAction func ᐅ⃣() {
        let 📍 = Bundle.main.url(forResource: "▶️", withExtension: "mp4")!
        let 🎮 = AVPlayerViewController()
        let 📺 = AVPlayer(url: 📍)
        🎮.player = 📺
        self.present(🎮, animated: true)
    }
    
    
    // ⚙️
    @IBAction func 🅂etting() {
        let 📍 = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(📍)
    }
    
    
    @IBAction func 🄰() {
        let 📍 = URL(string: "https://apps.apple.com/jp/app/id1444571751")!
        UIApplication.shared.open(📍)
    }
    
    
    @IBAction func 📁() {
        let ⓣypes = [UTType.pdf, UTType.zip]
        let 🎮 = UIDocumentPickerViewController(forOpeningContentTypes: ⓣypes, asCopy: true)
        🎮.delegate = self
        self.present(🎮, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        🅂tore(urls.first!)
    }
    
    func 🅂tore(_ 📦:URL) {
        if 📦.pathExtension == "pdf" {
            let 💾 = FileManager.default
            var 📍 = 💾.urls(for: .documentDirectory, in: .userDomainMask)[0]
            📍.appendPathComponent("🄸mported.pdf")
            
            try? 💾.removeItem(at: 📍)
            💾ZIPContents.removeUnzipFolder()
            
            try? 💾.copyItem(at: 📦, to: 📍)
            
            try? 💾.removeItem(at: 📦)
            
            📚 = PDFDocument(url: 📍)
            
            UserDefaults.standard.set(0, forKey: "🔖")
        }
        if 📦.pathExtension == "zip" {
            try! 💾ZIPContents.unzipAndSaveFiles(from: Bundle.main.url(forResource: "BundleZipFile", withExtension: "zip")!)
        }
    }
    
    
    // 📘 or 📄
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let 🎮 = segue.destination as! 📖_ViewController
        
        if (segue.identifier == "📘") {
            🎮.📚 = 📚
            if 📚.documentURL?.lastPathComponent == "🄸mported.pdf" {
                🎮.ⓕileType = .importedPDF
            }
            if 💾ZIPContents.dataExists {
                🎮.ⓕileType = .importedZIP
            }
        } else {
            let 📍 = Bundle.main.url(forResource: "📄", withExtension: "pdf")!
            🎮.📚 = PDFDocument(url: 📍)
        }
    }
}
