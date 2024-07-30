//
//  DogListViewModel.swift
//  Dogram
//
//  Created by Dhawal Mahajan on 30/07/24.
//

import Foundation
import UIKit
import DogImage

final class DogListViewModel {
    private(set) var images: [UIImage?] = []
    private(set) var imageCount: Int
    private let dogLibrary: DogImageLibrary
    init(imageCount: Int, dogLibrary: DogImageLibrary) {
        self.imageCount = imageCount
        self.dogLibrary = dogLibrary
        Task {
            images = await  getImages()
        }
    }
    
    func getImages() async  -> [UIImage?] {
        let imagesUrls = dogLibrary.getImages(number: imageCount)
        for url in imagesUrls {
            let image = await loadImage(from: url)
            images.append(image)
        }
        return images
    }
    private func loadImage(from url: URL? = nil) async -> UIImage? {
        guard let imageURL = url ?? dogLibrary.getImage() else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            return UIImage(data: data)
        } catch {
            print("Failed to load image: \(error)")
            return nil
        }
    }
    
}
