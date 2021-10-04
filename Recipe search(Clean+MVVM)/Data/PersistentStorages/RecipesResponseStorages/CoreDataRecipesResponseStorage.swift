//
//  CoreDataMoviesResponseStorage.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 04.10.2021.
//

import Foundation
import CoreData

final class CoreDataRecipesResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

    private func fetchRequest(for requestDto: RecipesRequestDTO) -> NSFetchRequest<RecipesRequestEntity> {
        let request: NSFetchRequest = RecipesRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                        #keyPath(RecipesRequestEntity.query), requestDto.query)
        return request
    }

    private func deleteResponse(for requestDto: RecipesRequestDTO, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: requestDto)

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}

extension CoreDataRecipesResponseStorage: RecipesResponseStorage {

    func getResponse(for requestDto: RecipesRequestDTO, completion: @escaping (Result<RecipesResponseDTO?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest(for: requestDto)
                let requestEntity = try context.fetch(fetchRequest).first

                completion(.success(requestEntity?.response?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }

    func save(response responseDto: RecipesResponseDTO, for requestDto: RecipesRequestDTO) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: requestDto, in: context)

                let requestEntity = requestDto.toEntity(in: context)
                requestEntity.response = responseDto.toEntity(in: context)

                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataRecipesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
