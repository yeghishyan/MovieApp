//
//  ImageService.swift
//

import SwiftUI
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    enum Size: String {
        case ld = "https://image.tmdb.org/t/p/w300"
        case sd = "https://image.tmdb.org/t/p/w500"
        case hd = "https://image.tmdb.org/t/p/w780/"
        case fullHd = "https://image.tmdb.org/t/p/w1080"
        case original = "https://image.tmdb.org/t/p/original"
    }
    
    @Published var image: UIImage?
    @Published var imagePath: String?
    
    init(imagePath: String?, size: Size = Size.sd) {
        self.imagePath = imagePath
        loadImage(size: size)
    }
    
    var imageCache = _imageCache

    func loadImage(size: Size) {
        guard let path = imagePath else { return }
        let url = URL(string: size.rawValue)!.appendingPathComponent(path)
        let urlString = url.absoluteString
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
