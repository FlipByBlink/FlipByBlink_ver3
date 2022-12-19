
import Foundation
import UIKit
import ZIPFoundation

class ZIPBookView: UIImageView {
    var zipBook: 📗ZipBookModel? = .Bundleデータのサンプル
    
    func setup() {
        loadImage()
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func loadImage() {
        self.image = zipBook?.現在表示するUIImage
    }
    
    func goToNextPage() {
        zipBook?.次のページへ移動する()
        self.loadImage()
    }
    
    func goToPreviousPage() {
        zipBook?.前のページへ移動する()
        self.loadImage()
    }
}

struct 📗ZipBookModel {
    var 解凍フォルダーURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("unzip")
    }
    
    var 現ページ番号: Int = 1
    
    private var ページPaths: [String]? {
        //try? FileManager.default.contentsOfDirectory(atPath: Self.解凍フォルダーURL.path()).sorted()
        if let ⓢubpaths = try? FileManager.default.subpathsOfDirectory(atPath: 解凍フォルダーURL.path).sorted() {
            return ⓢubpaths.filter { ⓟath in
                let ⓤrl = 解凍フォルダーURL.appendingPathComponent(ⓟath)
                let ⓡesourceValues = try? ⓤrl.resourceValues(forKeys: [.isDirectoryKey])
                if ⓡesourceValues?.isDirectory == true {
                    return false
                } else {
                    return true
                }
            }
        } else {
            return nil
        }
    }
    
    public var 現ページPath: String? {
        このページのPath(番号: 現ページ番号)
    }
    
    public var ページ数: Int? {
        ページPaths?.count
    }
    
    var 現在表示するUIImage: UIImage? {
        if let ⓟath = このページのPath(番号: 現ページ番号) {
            let ⓤrl = 解凍フォルダーURL.appendingPathComponent(ⓟath)
            guard let ⓓata = try? Data(contentsOf: ⓤrl) else { return nil }
            return UIImage(data: ⓓata)
        } else {
            return nil
        }
    }
    
    func ここへ移動できる(_ 番号: Int) -> Bool {
        if let ページPaths, ページPaths.indices.contains(番号) {
            return true
        } else {
            return false
        }
    }
    
    func このページのPath(番号: Int) -> String? {
        if !ここへ移動できる(番号) { return nil }
        if let ページPaths {
            return ページPaths[番号]
        } else {
            return nil
        }
    }
    
    mutating func 次のページへ移動する() {
        if ここへ移動できる(現ページ番号 + 1) {
            現ページ番号 += 1
        }
    }
    
    mutating func 前のページへ移動する() {
        if ここへ移動できる(現ページ番号 - 1) {
            現ページ番号 -= 1
        }
    }
    
    mutating func ジャンプ(_ ⓟageNumber: Int) {
        if ここへ移動できる(ⓟageNumber) {
            現ページ番号 = ⓟageNumber
        }
    }
    
    init?(_ ⓤrl: URL) {
        do {
            try ファイルを取り込む(from: ⓤrl)
        } catch {
            print("🚨", error.localizedDescription)
            return nil
        }
    }
    
    private func ファイルを取り込む(from ⓤrl: URL) throws {
        if FileManager.default.fileExists(atPath: 解凍フォルダーURL.path) {
            try FileManager.default.removeItem(at: 解凍フォルダーURL)
        }
        try FileManager.default.unzipItem(at: ⓤrl, to: 解凍フォルダーURL)//, preferredEncoding: .utf8)
        解凍フォルダーから画像ファイル以外を削除する()
    }
    
    private func 解凍フォルダーから画像ファイル以外を削除する() {
        if let ⓢubpaths = try? FileManager.default.subpathsOfDirectory(atPath: 解凍フォルダーURL.path) {
            for ⓢubpath in ⓢubpaths {
                let ⓤrl = 解凍フォルダーURL.appendingPathComponent(ⓢubpath)
                if let ⓓata = try? Data(contentsOf: ⓤrl) {
                    if UIImage(data: ⓓata) == nil {
                        try? FileManager.default.removeItem(at: ⓤrl)
                    }
                }
            }
        }
    }
    
    static var Bundleデータのサンプル: Self {
        let ⓤrl = Bundle.main.url(forResource: "BundleZipFile", withExtension: "zip")!
        return Self(ⓤrl)!
    }
    
    static var DataAssetのサンプル: Self {
        let データアセット: Data = NSDataAsset(name: "SampleZIP")!.data
        let ⓣemporaryDirectoryUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let データURL: URL = ⓣemporaryDirectoryUrl.appendingPathComponent("zipFile.zip")
        try? FileManager.default.removeItem(at: データURL)
        FileManager.default.createFile(atPath: データURL.path, contents: データアセット)
        return Self(データURL)!
    }
}
