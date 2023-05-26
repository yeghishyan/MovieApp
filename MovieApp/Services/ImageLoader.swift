//
//  ImageService.swift
//

import SwiftUI
import UIKit
import Combine

import SwiftUI
import UIKit
//
//private let _imageCache = NSCache<AnyObject, AnyObject>()
//
//class ImageLoader: ObservableObject {
//    enum Quality: String {
//        case ld = "https://image.tmdb.org/t/p/w300"
//        case sd = "https://image.tmdb.org/t/p/w500"
//        case hd = "https://image.tmdb.org/t/p/w780/"
//        case fullHd = "https://image.tmdb.org/t/p/w1280"
//        case original = "https://image.tmdb.org/t/p/original"
//    }
//
//    @Published var image: UIImage?
//    @Published var imagePath: String?
//
//    init(path: String?, quality: Quality = Quality.sd) {
//        self.imagePath = path
//        loadImage(size: quality)
//    }
//
//    var imageCache = _imageCache
//
//    func loadImage(size: Quality) {
//        guard let path = imagePath else { return }
//        let url = URL(string: size.rawValue)!.appendingPathComponent(path)
//        let urlString = url.absoluteString
//
//        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//
//        DispatchQueue.global(qos: .background).async { [weak self] in
//            guard let self = self else { return }
//            do {
//                let data = try Data(contentsOf: url)
//                guard let image = UIImage(data: data) else { return }
//
//                self.imageCache.setObject(image, forKey: urlString as AnyObject)
//                DispatchQueue.main.async { [weak self] in
//                    self?.image = image
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//}


final class ImageLoaderCache {
    public static let shared = ImageLoaderCache()

    private var loaders: NSCache<NSString, ImageLoader> = NSCache()

    func loaderFor(path: String?, quality: ImageService.Quality) -> ImageLoader {
        let key = NSString(string: "\(path ?? "missing")#\(quality.rawValue)")
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            let loader = ImageLoader(path: path, size: quality)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
}

final class ImageLoader: ObservableObject {
    let path: String?
    let size: ImageService.Quality

    var objectWillChange: AnyPublisher<UIImage?, Never> = Publishers.Sequence<[UIImage?], Never>(sequence: []).eraseToAnyPublisher()

    @Published public var image: UIImage? = nil

    public var cancellable: AnyCancellable?

    public init(path: String?, size: ImageService.Quality = ImageService.Quality.sd) {
        self.size = size
        self.path = path

        self.objectWillChange = $image.handleEvents(receiveSubscription: { [weak self] sub in
            self?.loadImage()
        }, receiveCancel: { [weak self] in
            self?.cancellable?.cancel()
        }).eraseToAnyPublisher()
    }

    private func loadImage() {
        guard let imagePath = path, image == nil else {
            return
        }
        cancellable = ImageService.shared.fetchImage(imagePath: imagePath, quality: size)
            .receive(on: DispatchQueue.main)
            .assign(to: \ImageLoader.image, on: self)
    }

    deinit {
        cancellable?.cancel()
    }
}
