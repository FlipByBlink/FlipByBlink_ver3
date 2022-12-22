
import Foundation
import UIKit
import ZIPFoundation

class 📗ZIPBookView: UIImageView {
    private(set) var currentPageNumber: Int = 0 {
        didSet {
            self.loadImage()
        }
    }
    
    var pageImages: [Int: UIImage] = 💾ZIPContents.getPageImages()
    
    func setup() {
        self.loadImage()
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func loadImage() {
        self.image = self.currentPageImage
    }
    
    var currentPageImage: UIImage? {
        self.pageImages[self.currentPageNumber]
    }
    
    var pageCount: Int {
        self.pageImages.count
    }
    
    func canGoToNextPage() -> Bool {
        self.pageImages[self.currentPageNumber + 1] != nil
    }
    
    func goToNextPage() {
        if self.canGoToNextPage() {
            self.currentPageNumber += 1
        }
    }
    
    func goToPreviousPage() {
        if self.pageImages[self.currentPageNumber - 1] != nil {
            self.currentPageNumber -= 1
        }
    }
    
    func go(to ⓟageNumber: Int) {
        if self.pageImages[ⓟageNumber] != nil {
            self.currentPageNumber = ⓟageNumber
        }
    }
}

struct 💾ZIPContents {
    static func getPageImages() -> [Int: UIImage] {
        do {
            return try 📑pageImages
        } catch {
            print("🚨", #function, error.localizedDescription)
            return [:]
        }
    }
    
    static func getPageURLs() throws -> [Int: URL] {
        try 📑pageURLs
    }
    
    static func getCoverImage() throws -> UIImage? {
        if let ⓤrl = try 📑pageURLs[0] {
            return UIImage(contentsOfFile: ⓤrl.path)
        } else {
            return nil
        }
    }
    
    static var dataExists: Bool {
        FileManager.default.fileExists(atPath: 🔗unzipFolderURL.path)
    }
    
    static func unzipAndSaveFiles(from ⓤrl: URL) throws {
        if FileManager.default.fileExists(atPath: 🔗unzipFolderURL.path) {
            try 🗑removeUnzipFolder()
        }
        try FileManager.default.unzipItem(at: ⓤrl, to: 🔗unzipFolderURL)//, preferredEncoding: .utf8)
        try 🗑removeFilesExpectImages()
    }
    
    static func removeUnzipFolder() {
        try? 🗑removeUnzipFolder()
    }
    
    //MARK: private code
    private static var 📑pageImages: [Int: UIImage] {
        get throws {
            var ⓢubpaths = try FileManager.default.subpathsOfDirectory(atPath: 🔗unzipFolderURL.path)
            try ⓢubpaths.removeAll { try 🚩isDirecrory($0) }
            ⓢubpaths.sort { $0.localizedStandardCompare($1) == .orderedAscending }
            //alternative: ⓢubpaths.sort { $0.compare($1, options: .numeric) == .orderedAscending }
            let ⓔmptyIndices: [Int: UIImage] = [:]
            return ⓢubpaths.reduce(into: ⓔmptyIndices) { ⓟartialResult, ⓢubpath in
                if let ⓘndex = ⓢubpaths.firstIndex(of: ⓢubpath) {
                    let ⓤrl = 🔗unzipFolderURL.appendingPathComponent(ⓢubpath)
                    if let ⓘmage = UIImage(contentsOfFile: ⓤrl.path) {
                        ⓟartialResult[ⓘndex] = ⓘmage
                    }
                }
            }
        }
    }
    
    private static var 📑pageURLs: [Int: URL] {
        get throws {
            var ⓢubpaths = try FileManager.default.subpathsOfDirectory(atPath: 🔗unzipFolderURL.path)
            try ⓢubpaths.removeAll { try 🚩isDirecrory($0) }
            ⓢubpaths.sort { $0.localizedStandardCompare($1) == .orderedAscending }
            //alternative: ⓢubpaths.sort { $0.compare($1, options: .numeric) == .orderedAscending }
            let ⓔmptyIndices: [Int: URL] = [:]
            return ⓢubpaths.reduce(into: ⓔmptyIndices) { ⓟartialResult, ⓢubpath in
                if let ⓘndex = ⓢubpaths.firstIndex(of: ⓢubpath) {
                    ⓟartialResult[ⓘndex] = 🔗unzipFolderURL.appendingPathComponent(ⓢubpath)
                }
            }
        }
    }
    
    private static var 🔗unzipFolderURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("unzip")
    }
    
    private static func 🗑removeUnzipFolder() throws {
        try FileManager.default.removeItem(at: 🔗unzipFolderURL)
    }
    
    private static func 🗑removeFilesExpectImages() throws {
        let ⓢubpaths = try FileManager.default.subpathsOfDirectory(atPath: 🔗unzipFolderURL.path)
        for ⓢubpath in ⓢubpaths {
            if try 🚩isDirecrory(ⓢubpath) == false {
                let ⓤrl = 🔗unzipFolderURL.appendingPathComponent(ⓢubpath)
                let ⓓata = try Data(contentsOf: ⓤrl)
                if UIImage(data: ⓓata) == nil {
                    try FileManager.default.removeItem(at: ⓤrl)
                }
            }
        }
    }
    
    private static func 🚩isDirecrory(_ ⓢubpath: String) throws -> Bool {
        let ⓤrl = 🔗unzipFolderURL.appendingPathComponent(ⓢubpath)
        let ⓡesourceValues = try ⓤrl.resourceValues(forKeys: [.isDirectoryKey])
        return ⓡesourceValues.isDirectory == true
    }
}
