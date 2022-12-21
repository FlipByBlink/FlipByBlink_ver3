
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
            
            if FileManager.default.fileExists(atPath: 🄵ile.importedPDFURL.path){
                📚 = PDFDocument(url: 🄵ile.importedPDFURL)
            } else {
                📚 = PDFDocument(data: 🄵ile.presetPDFData)
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
                🎮.ⓟresentedFile = .importedPDF
            }
            if 💾ZIPContents.dataExists {
                🎮.ⓟresentedFile = .importedZIP
            }
        } else {
            let 📍 = Bundle.main.url(forResource: "📄", withExtension: "pdf")!
            🎮.📚 = PDFDocument(url: 📍)
        }
    }
}

struct 🄵ile {
    enum MainContent {
        case presetPDF
        case importedPDF
        case importedZIP
        
        var coverImage: UIImage? {
            switch self {
                case .presetPDF:
                    return UIImage(data: NSDataAsset(name: "🄿reset")!.data)
                case .importedPDF:
                    let ⓓocument = PDFDocument(url: 🄵ile.importedPDFURL)
                    return ⓓocument?.page(at: 0)?.thumbnail(of: .init(width: 1000, height: 1000), for: .mediaBox)
                case .importedZIP:
                    return UIImage(contentsOfFile: try! 💾ZIPContents.getPageURL(number: 1).path)
            }
        }
    }
    
    enum PresentedFile {
        case presetPDF
        case appDocumentPDF
        case importedPDF
        case importedZIP
    }
    
    static var presetPDFData: Data {
        NSDataAsset(name: "🄿reset")!.data
    }
    
    static var importedPDFURL: URL {
        let ⓤrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return ⓤrl.appendingPathComponent("🄸mported.pdf")
    }
}
