import UIKit

class 📗ZIPBookView: UIImageView {
    private var pageURLs: [Int: URL] = 🅉IPContents.getPageURLs()
    private var currentPageNumber: Int = 0
    private var preloadedNextPageImage: UIImage? = nil
    private var preloadedPreviousPageImage: UIImage? = nil
    
    func canGoToNextPage() -> Bool {
        self.pageURLs[self.currentPageNumber + 1] != nil
    }
    
    func goToNextPage() {
        if let ⓝextPageImage = self.preloadedNextPageImage {
            self.image = ⓝextPageImage
            self.preloadedNextPageImage = nil
            self.currentPageNumber += 1
            self.preloadImages()
        }
    }
    
    func goToPreviousPage() {
        if let ⓟreviousPageImage = self.preloadedPreviousPageImage {
            self.image = ⓟreviousPageImage
            self.preloadedPreviousPageImage = nil
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
    
    var representedCurrentPageNumber: Int {
        self.currentPageNumber + 1
    }
    
    func setLayerShadow() {
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.25
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    private func preloadImages() {
        let ⓝextPageNumber = self.currentPageNumber + 1
        let ⓟreviousPageNumber = self.currentPageNumber - 1
        if let ⓤrl = self.pageURLs[ⓝextPageNumber] {
            let ⓘmage = UIImage(contentsOfFile: ⓤrl.path)
            ⓘmage?.prepareForDisplay { ⓟreparedImage in
                DispatchQueue.main.async {
                    if self.currentPageNumber + 1 == ⓝextPageNumber {
                        self.preloadedNextPageImage = ⓟreparedImage
                    }
                }
            }
        } else {
            self.preloadedNextPageImage = nil
        }
        if let ⓤrl = self.pageURLs[ⓟreviousPageNumber] {
            let ⓘmage = UIImage(contentsOfFile: ⓤrl.path)
            ⓘmage?.prepareForDisplay { ⓟreparedImage in
                DispatchQueue.main.async {
                    if self.currentPageNumber - 1 == ⓟreviousPageNumber {
                        self.preloadedPreviousPageImage = ⓟreparedImage
                    }
                }
            }
        } else {
            self.preloadedPreviousPageImage = nil
        }
    }
}
