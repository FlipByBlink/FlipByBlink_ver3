
import UIKit
import AVKit
import PDFKit
import ARKit


class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    
    @IBOutlet weak var ๐: UIButton! {
        didSet {
            ๐.layer.shadowColor = UIColor.gray.cgColor
            ๐.layer.shadowOpacity = 0.8
            ๐.layer.shadowRadius = 4
            ๐.layer.shadowOffset = .zero
            ๐.imageView?.contentMode = .scaleAspectFit
            
            let ๐พ = FileManager.default
            var ๐ = ๐พ.urls(for: .documentDirectory, in: .userDomainMask)[0]
            ๐.appendPathComponent("๐ธmported.pdf")
            if ๐พ.fileExists(atPath: ๐.path){
                ๐ = PDFDocument(url: ๐)
            } else {
                ๐ = PDFDocument(data: NSDataAsset(name: "๐ฟreset")!.data)
            }
        }
    }
    
    
    var ๐: PDFDocument! {
        didSet {
            let ๐ = CGSize(width: 2000, height: 2000)
            let ๐ผ = ๐.page(at: 0)?.thumbnail(of: ๐, for: .mediaBox)
            ๐.setImage(๐ผ, for: .normal)
        }
    }
    
    
    @IBAction func แโฃ() {
        let ๐ = Bundle.main.url(forResource: "โถ๏ธ", withExtension: "mp4")!
        let ๐ฎ = AVPlayerViewController()
        let ๐บ = AVPlayer(url: ๐)
        ๐ฎ.player = ๐บ
        self.present(๐ฎ, animated: true)
    }
    
    
    // โ๏ธ
    @IBAction func ๐etting() {
        let ๐ = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(๐)
    }
    
    
    @IBAction func ๐ฐ() {
        let ๐ = URL(string: "https://apps.apple.com/jp/app/id1444571751")!
        UIApplication.shared.open(๐)
    }
    
    
    @IBAction func ๐() {
        let ๐ท = UTType(filenameExtension: "pdf")!
        let ๐ฎ = UIDocumentPickerViewController(forOpeningContentTypes: [๐ท], asCopy: true)
        ๐ฎ.delegate = self
        self.present(๐ฎ, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        ๐tore(urls.first!)
    }
    
    func ๐tore(_ ๐ฆ:URL) {
        let ๐พ = FileManager.default
        var ๐ = ๐พ.urls(for: .documentDirectory, in: .userDomainMask)[0]
        ๐.appendPathComponent("๐ธmported.pdf")
        
        try? ๐พ.removeItem(at: ๐)
        
        try? ๐พ.copyItem(at: ๐ฆ, to: ๐)
        
        try? ๐พ.removeItem(at: ๐ฆ)
        
        ๐ = PDFDocument(url: ๐)
        
        UserDefaults.standard.set(0, forKey: "๐")
    }
    
    
    // ๐ or ๐
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ๐ฎ = segue.destination as! ๐_ViewController
        
        if (segue.identifier == "๐") {
            ๐ฎ.๐ = ๐
        } else {
            let ๐ = Bundle.main.url(forResource: "๐", withExtension: "pdf")!
            ๐ฎ.๐ = PDFDocument(url: ๐)
        }
    }
    
    
}

