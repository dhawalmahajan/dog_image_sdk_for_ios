//
//  CoreDataDogImageRepository.swift
//  Dogram
//
//  Created by Dhawal Mahajan on 31/07/24.
//

import Foundation
import CoreData

protocol DogImageRepository {
    func fetchAllImages() -> [DogImage]
    func saveImage(url: URL)
}

class CoreDataDogImageRepository: DogImageRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }

    func fetchAllImages() -> [DogImage] {
           let fetchRequest: NSFetchRequest<DogImageEntity> = DogImageEntity.fetchRequest()
           
           do {
               let result = try context.fetch(fetchRequest)
               return result.compactMap {
                   guard let urlString = $0.dogImageUrl, let url = URL(string: urlString) else { return nil }
                   return DogImage(url: url)
               }
           } catch {
               print("Fetch error: \(error)")
               return []
           }
       }

    func saveImage(url: URL) {
        let entity = DogImageEntity(context: context)
        entity.dogImageUrl = url.absoluteString
        
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
}
