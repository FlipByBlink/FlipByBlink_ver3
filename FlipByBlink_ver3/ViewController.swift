
import UIKit
import AVKit
import PDFKit
import ARKit


class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    var ⓕile: 🄵ile.MainContent = .presetPDF
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadFileStatus()
    }
    
    
    @IBOutlet weak var 📘: UIButton! {
        didSet {
            📘.layer.shadowColor = UIColor.gray.cgColor
            📘.layer.shadowOpacity = 0.8
            📘.layer.shadowRadius = 4
            📘.layer.shadowOffset = .zero
            📘.imageView?.contentMode = .scaleAspectFit
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
        do {
            try 🄵ile.store(from: urls.first!)
            loadFileStatus()
        } catch {
            print("🚨", #function, error.localizedDescription)
        }
    }
    
    func loadFileStatus() {
        ⓕile.reload()
        📘.setImage(ⓕile.getCoverImage(of: self.📘.frame.size), for: .normal)
    }
    
    
    // 📘 or 📄
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let 🎮 = segue.destination as! 📖_ViewController
        
        if (segue.identifier == "📘") {
            🎮.📚 = PDFDocument()
            switch ⓕile {
                case .presetPDF:
                    🎮.ⓟresentedFile = .presetPDF
                    🎮.📚 = PDFDocument(data: 🄵ile.presetPDFData)!
                case .importedPDF:
                    if let ⓓocument = PDFDocument(url: 🄵ile.importedPDFURL) {
                        🎮.ⓟresentedFile = .importedPDF
                        🎮.📚 = ⓓocument
                    }
                case .importedZIP:
                    🎮.ⓟresentedFile = .importedZIP
            }
        } else {
            🎮.📚 = PDFDocument(url: 🄵ile.appdocumentPDFURL)!
        }
    }
}

struct 🄵ile {
    enum MainContent {
        case presetPDF
        case importedPDF
        case importedZIP
        
        func getCoverImage(of ⓢize: CGSize) -> UIImage? {
            let ⓘmageSize = ⓢize.applying(CGAffineTransform(scaleX: 3, y: 3))
            switch self {
                case .presetPDF:
                    let ⓓocument = PDFDocument(data: NSDataAsset(name: "🄿reset")!.data)
                    return ⓓocument?.page(at: 0)?.thumbnail(of: ⓘmageSize, for: .mediaBox)
                case .importedPDF:
                    let ⓓocument = PDFDocument(url: 🄵ile.importedPDFURL)
                    return ⓓocument?.page(at: 0)?.thumbnail(of: ⓘmageSize, for: .mediaBox)
                case .importedZIP:
                    return try! 💾ZIPContents.getCoverImage(of: ⓘmageSize)
            }
        }
        
        mutating func reload() {
            let 🚩importedPDFExists = FileManager.default.fileExists(atPath: 🄵ile.importedPDFURL.path)
            let 🚩importedZIPExists = 💾ZIPContents.dataExists
            switch (🚩importedPDFExists, 🚩importedZIPExists) {
                case (false, false):
                    self = .presetPDF
                case (true, false):
                    self = .importedPDF
                case (false, true):
                    self = .importedZIP
                default:
                    assertionFailure()
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
    
    static var appdocumentPDFURL: URL {
        Bundle.main.url(forResource: "📄", withExtension: "pdf")!
    }
    
    static func store(from 📦: URL) throws {
        switch 📦.pathExtension {
            case "pdf":
                let ⓕm = FileManager()
                if ⓕm.fileExists(atPath: Self.importedPDFURL.path) {
                    try ⓕm.removeItem(at: Self.importedPDFURL)
                }
                try ⓕm.copyItem(at: 📦, to: Self.importedPDFURL)
                try ⓕm.removeItem(at: 📦)
                💾ZIPContents.removeUnzipFolder()
                UserDefaults.standard.set(0, forKey: "🔖")
            case "zip":
                try 💾ZIPContents.unzipAndSaveFiles(from: 📦)
                try FileManager.default.removeItem(at: 📦)
                if FileManager.default.fileExists(atPath: Self.importedPDFURL.path) {
                    try FileManager.default.removeItem(at: Self.importedPDFURL)
                }
                UserDefaults.standard.set(0, forKey: "🔖")
            default:
                assertionFailure()
        }
    }
}
