
import Foundation
import UIKit
import ZIPFoundation

class ZIPBookView: UIImageView {
    var zipBook: 📗ZIPBook = 📗ZIPBook()
    
    func setup() {
        try! 💾ZIPContents.unzipAndSaveFiles(from: Bundle.main.url(forResource: "BundleZipFile", withExtension: "zip")!)
        
        loadImage()
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func loadImage() {
        if let ⓤrl = try? zipBook.currentPageURL {
            self.image = UIImage(contentsOfFile: ⓤrl.path)
        }
    }
    
    func goToNextPage() {
        zipBook.goToNextPage()
        self.loadImage()
    }
    
    func goToPreviousPage() {
        zipBook.goToPreviousPage()
        self.loadImage()
    }
}

class 📗ZIPBook {
    private(set) var currentPageNumber: Int = 1
    
    var currentPageURL: URL {
        get throws {
            try 💾ZIPContents.getPageURL(number: self.currentPageNumber)
        }
    }
    
    var pageCount: Int {
        get throws {
            try 💾ZIPContents.getPageSubpaths().count
        }
    }
    
    func canGoToNextPage() -> Bool {
        do {
            return try 💾ZIPContents.pageExists(number: self.currentPageNumber + 1)
        } catch {
            assertionFailure("🚨" + error.localizedDescription)
            return false
        }
    }
    
    func goToNextPage() {
        if self.canGoToNextPage() {
            self.currentPageNumber += 1
        }
    }
    
    func goToPreviousPage() {
        do {
            if try 💾ZIPContents.pageExists(number: self.currentPageNumber - 1) {
                self.currentPageNumber -= 1
            }
        } catch {
            assertionFailure("🚨" + error.localizedDescription)
        }
    }
    
    func go(to ⓟageNumber: Int) throws {
        if try 💾ZIPContents.pageExists(number: ⓟageNumber) {
            self.currentPageNumber = ⓟageNumber
        } else {
            throw 🚨Error.noPageExists
        }
        enum 🚨Error: Error {
            case noPageExists
        }
    }
}

struct 💾ZIPContents {
    static func getPageSubpaths() throws -> [Int: String] {
        try 📑pageSubpaths
    }
    
    static func pageExists(number ⓝumber: Int) throws -> Bool {
        try 📑pageSubpaths.keys.contains(ⓝumber)
    }
    
    static func getPageSubpath(number ⓝumber: Int) throws -> String {
        try 📍pageSubpath(number: ⓝumber)
    }
    
    static func getPageURL(number ⓝumber: Int) throws -> URL {
        🔗unzipFolderURL.appendingPathComponent(try 📍pageSubpath(number: ⓝumber))
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
    private static var 📑pageSubpaths: [Int: String] {
        get throws {
            let ⓢubpaths = try FileManager.default.subpathsOfDirectory(atPath: 🔗unzipFolderURL.path).sorted()
            let ⓢubpathsExpectDirecrory = try ⓢubpaths.filter { ⓢubpath in
                try 🚩isNotDirecrory(ⓢubpath)
            }
            let ⓔmptyIndices: [Int: String] = [:]
            return ⓢubpathsExpectDirecrory.reduce(into: ⓔmptyIndices) { ⓟartialResult, ⓢubpath in
                if let ⓘndex = ⓢubpathsExpectDirecrory.firstIndex(of: ⓢubpath) {
                    ⓟartialResult[ⓘndex + 1] = ⓢubpath
                }
            }
        }
    }
    
    private static func 📍pageSubpath(number ⓝumber: Int) throws -> String {
        let ⓟageSubpaths = try 📑pageSubpaths
        if let ⓢubpath = ⓟageSubpaths[ⓝumber] {
            return ⓢubpath
        } else {
            assertionFailure(#function)
            throw 🚨Error.improperPageNumber
        }
        enum 🚨Error: Error {
            case improperPageNumber
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
            if try 🚩isNotDirecrory(ⓢubpath) {
                let ⓤrl = 🔗unzipFolderURL.appendingPathComponent(ⓢubpath)
                let ⓓata = try Data(contentsOf: ⓤrl)
                if UIImage(data: ⓓata) == nil {
                    try FileManager.default.removeItem(at: ⓤrl)
                }
            }
        }
    }
    
    private static func 🚩isNotDirecrory(_ ⓢubpath: String) throws -> Bool {
        let ⓤrl = 🔗unzipFolderURL.appendingPathComponent(ⓢubpath)
        let ⓡesourceValues = try ⓤrl.resourceValues(forKeys: [.isDirectoryKey])
        if ⓡesourceValues.isDirectory == true {
            return false
        } else {
            return true
        }
    }
}
