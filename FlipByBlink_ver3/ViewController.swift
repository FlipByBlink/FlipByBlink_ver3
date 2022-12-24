
import UIKit
import AVKit
import PDFKit
import ARKit

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    private var loadedFile: 🄵ile.MainContent = .presetPDF
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadFileStatus()
    }
    
    private func loadFileStatus() {
        self.loadedFile.reload()
        let ⓘmage = self.loadedFile.getCoverImage(of: self.📘openBookButton.frame.size)
        self.📘openBookButton.setImage(ⓘmage, for: .normal)
    }
    
    @IBOutlet weak var 📘openBookButton: UIButton! {
        didSet {
            self.📘openBookButton.imageView?.contentMode = .scaleAspectFit
            self.📘openBookButton.layer.shadowColor = UIColor.black.cgColor
            self.📘openBookButton.layer.shadowOpacity = 0.25
            self.📘openBookButton.layer.shadowRadius = 3
            self.📘openBookButton.layer.shadowOffset = .zero
        }
    }
    
    @IBAction func ᐅ⃣playVideo() {
        let ⓤrl = Bundle.main.url(forResource: "▶️", withExtension: "mp4")!
        let ⓥc = AVPlayerViewController()
        ⓥc.player = AVPlayer(url: ⓤrl)
        self.present(ⓥc, animated: true)
    }
    
    // ⚙️
    @IBAction func 🛠️openSetting() {
        let ⓤrl = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(ⓤrl)
    }
    
    @IBAction func A⃣openAppStorePage() {
        let ⓤrl = URL(string: "https://apps.apple.com/jp/app/id1444571751")!
        UIApplication.shared.open(ⓤrl)
    }
    
    @IBOutlet weak var 🌀indicatorView: UIActivityIndicatorView!
    
    @IBAction func 📁openDocumentPicker() {
        let ⓣypes = [UTType.pdf, UTType.zip, UTType(filenameExtension: "cbz")!]
        let ⓥc = UIDocumentPickerViewController(forOpeningContentTypes: ⓣypes, asCopy: true)
        ⓥc.delegate = self
        self.present(ⓥc, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.🌀indicatorView.startAnimating()
        }
    }
    
    // UIDocumentPickerDelegate
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        do {
            try 🄵ile.store(from: urls.first!)
            self.loadFileStatus()
        } catch {
            print("🚨", #function, error.localizedDescription)
        }
        self.🌀indicatorView.stopAnimating()
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        self.🌀indicatorView.stopAnimating()
    }
    
    // SceneDelegate.scene(_ :, openURLContexts:)
    func importFileFromOtherApp(url ⓤrl: URL) throws {
        try 🄵ile.store(from: ⓤrl)
        self.loadFileStatus()
    }
    
    // 📘openBookButton or 📄openAppDocumentButton
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let 📖vc = segue.destination as! 📖ReadingViewController
        if segue.identifier == "📘" {
            📖vc.pdfDocument = PDFDocument()
            switch self.loadedFile {
                case .presetPDF:
                    📖vc.presentedFile = .presetPDF
                    📖vc.pdfDocument = PDFDocument(data: 🄵ile.presetPDFData)!
                case .importedPDF:
                    if let ⓓocument = PDFDocument(url: 🄵ile.importedPDFURL) {
                        📖vc.presentedFile = .importedPDF
                        📖vc.pdfDocument = ⓓocument
                    }
                case .importedZIP:
                    📖vc.presentedFile = .importedZIP
            }
        } else {
            📖vc.pdfDocument = PDFDocument(url: 🄵ile.appdocumentPDFURL)!
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
    
    static func store(from 📦url: URL) throws {
        switch 📦url.pathExtension {
            case "pdf":
                let ⓕm = FileManager()
                if ⓕm.fileExists(atPath: Self.importedPDFURL.path) {
                    try ⓕm.removeItem(at: Self.importedPDFURL)
                }
                try ⓕm.copyItem(at: 📦url, to: Self.importedPDFURL)
                try ⓕm.removeItem(at: 📦url)
                💾ZIPContents.removeUnzipFolder()
                UserDefaults.standard.set(0, forKey: "🔖")
            case "zip", "cbz":
                try 💾ZIPContents.unzipAndSaveFiles(from: 📦url)
                try FileManager.default.removeItem(at: 📦url)
                if FileManager.default.fileExists(atPath: Self.importedPDFURL.path) {
                    try FileManager.default.removeItem(at: Self.importedPDFURL)
                }
                UserDefaults.standard.set(0, forKey: "🔖")
            default:
                assertionFailure()
        }
    }
}
