import UIKit
import PDFKit

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
                    return try! 🅉IPContents.getCoverImage(of: ⓘmageSize)
            }
        }
        
        mutating func reload() {
            let ⓘmportedPDFExists = FileManager.default.fileExists(atPath: 🄵ile.importedPDFURL.path)
            let ⓘmportedZIPExists = 🅉IPContents.dataExists
            switch (ⓘmportedPDFExists, ⓘmportedZIPExists) {
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
    
    static func store(from ⓤrl: URL) throws {
        switch ⓤrl.pathExtension {
            case "pdf":
                let ⓕm = FileManager()
                if ⓕm.fileExists(atPath: Self.importedPDFURL.path) {
                    try ⓕm.removeItem(at: Self.importedPDFURL)
                }
                try ⓕm.copyItem(at: ⓤrl, to: Self.importedPDFURL)
                try ⓕm.removeItem(at: ⓤrl)
                🅉IPContents.removeUnzipFolder()
                🅄serDefaults.setBookmarkNumber(0)
            case "zip", "cbz":
                try 🅉IPContents.unzipAndSaveFiles(from: ⓤrl)
                try FileManager.default.removeItem(at: ⓤrl)
                if FileManager.default.fileExists(atPath: Self.importedPDFURL.path) {
                    try FileManager.default.removeItem(at: Self.importedPDFURL)
                }
                🅄serDefaults.setBookmarkNumber(0)
            default:
                assertionFailure()
        }
    }
}
