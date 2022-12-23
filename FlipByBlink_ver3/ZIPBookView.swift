
import Foundation
import UIKit
import ZIPFoundation

class 📗ZIPBookView: UIImageView {
    private(set) var currentPageNumber: Int = 0
    
    var pageURLs: [Int: URL] = 💾ZIPContents.getPageURLs()
    
    var nextPageImage: UIImage? = nil
    var previousPageImage: UIImage? = nil
    
    func preloadImages() {
        let ⓝextPageNumber = currentPageNumber + 1
        let ⓟreviousPageNumber = currentPageNumber - 1
        if let ⓤrl = self.pageURLs[ⓝextPageNumber] {
            let ⓘmage = UIImage(contentsOfFile: ⓤrl.path)
            ⓘmage?.prepareForDisplay { ⓟreparedImage in
                DispatchQueue.main.async {
                    if self.currentPageNumber + 1 == ⓝextPageNumber {
                        self.nextPageImage = ⓟreparedImage
                    }
                }
            }
        } else {
            self.nextPageImage = nil
        }
        if let ⓤrl = self.pageURLs[ⓟreviousPageNumber] {
            let ⓘmage = UIImage(contentsOfFile: ⓤrl.path)
            ⓘmage?.prepareForDisplay { ⓟreparedImage in
                DispatchQueue.main.async {
                    if self.currentPageNumber - 1 == ⓟreviousPageNumber {
                        self.previousPageImage = ⓟreparedImage
                    }
                }
            }
        } else {
            self.previousPageImage = nil
        }
    }
    
    func canGoToNextPage() -> Bool {
        self.pageURLs[self.currentPageNumber + 1] != nil
    }
    
    func goToNextPage() {
        if self.nextPageImage != nil {
            self.image = self.nextPageImage
            self.nextPageImage = nil
            self.currentPageNumber += 1
            self.preloadImages()
        }
    }
    
    func goToPreviousPage() {
        if self.previousPageImage != nil {
            self.image = self.previousPageImage
            self.previousPageImage = nil
            self.currentPageNumber -= 1
            self.preloadImages()
        }
    }
    
    func go(to ⓟageNumber: Int) {
        if let ⓤrl = self.pageURLs[ⓟageNumber] {
            self.image = UIImage(contentsOfFile: ⓤrl.path)
            self.currentPageNumber = ⓟageNumber
            self.preloadImages()
        }
    }
    
    var pageCount: Int {
        self.pageURLs.count
    }
    
    func setup() {
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.gray.cgColor
    }
}

struct 💾ZIPContents {
    static func getPageURLs() -> [Int: URL] {
        do {
            return try 📑pageURLs
        } catch {
            print("🚨", #function, error.localizedDescription)
            return [:]
        }
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
