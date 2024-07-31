//
//  DogViewModel.swift
//  Dogram
//
//  Created by Dhawal Mahajan on 31/07/24.
//

import Foundation
import UIKit
final class DogImageViewModel {
    private let dogImageRepository: DogImageRepository
    private(set) var images: [UIImage?] = []
    private(set) var imagesUrls: [URL?] = []

    init(dogImageRepository: DogImageRepository) {
        self.dogImageRepository = dogImageRepository
    }

    func getNextImage() async -> UIImage? {
        if let url = dogImageRepository.fetchAllImages().first?.url {
            return await loadImage(from: url)
        }
        return nil
    }

    func getImages(number: Int) async -> [UIImage?] {
        imagesUrls = dogImageRepository.fetchAllImages().map { $0.url }
        
        var images: [UIImage?] = []
        for url in imagesUrls.prefix(number) {
            let image = await loadImage(from: url)
            images.append(image)
        }
        return images
    }

    func getPreviousImage() async -> UIImage? {
        if let url = dogImageRepository.fetchAllImages().last?.url {
            return await loadImage(from: url)
        }
        return nil
    }

    private func loadImage(from url: URL?) async -> UIImage? {
        guard let imageURL = url else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            return UIImage(data: data)
        } catch {
            print("Failed to load image: \(error)")
            return nil
        }
    }

    func saveImage(url: URL) {
        dogImageRepository.saveImage(url: url)
    }

}
