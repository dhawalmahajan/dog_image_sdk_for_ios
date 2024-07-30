//
//  DogViewModel.swift
//  Dogram
//
//  Created by Dhawal Mahajan on 30/07/24.
//

import UIKit
import DogImage
protocol DogService {
    func getNextImage() async -> UIImage?
//    func getImages(number: Int) async -> [UIImage?]
    func getPreviousImage() async -> UIImage?
}

@MainActor
final class DogViewModel: DogService {
    private (set) var images:[UIImage?] = []
    private (set) var imagesUrls:[URL?] = []
    
  
     let dogLibrary: DogImageLibrary = DogImageLibrary()
    func getNextImage() async -> UIImage? {
        await loadImage(from: dogLibrary.getNextImage())
    }
    
   
    
    func getPreviousImage() async -> UIImage? {
        await loadImage(from: dogLibrary.getPreviousImage())
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
