//
//  CoreDataRcipesQueriesStorage.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 04.10.2021.
//

import Foundation
import CoreData

final class CoreDataRecipesQueriesStorage {

    private let maxStorageLimit: Int
    private let coreDataStorage: CoreDataStorage

    init(maxStorageLimit: Int, coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.maxStorageLimit = maxStorageLimit
        self.coreDataStorage = coreDataStorage
    }
}

extension CoreDataRecipesQueriesStorage: RecipesQueriesStorage {
    
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[RecipeQuery], Error>) -> Void) {
        
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = RecipeQueryEntity.fetchRequest()
                request.fetchLimit = maxCount
                let result = try context.fetch(request).map { $0.toDomain() }

                completion(.success(result))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func saveRecentQuery(query: RecipeQuery, completion: @escaping (Result<RecipeQuery, Error>) -> Void) {

        coreDataStorage.performBackgroundTask { [weak self] context in
            guard let self = self else { return }
            do {
                try self.cleanUpQueries(for: query, inContext: context)
                let entity = RecipeQueryEntity(recipeQuery: query, insertInto: context)
                try context.save()

                completion(.success(entity.toDomain()))
            } catch {
                completion(.failure(CoreDataStorageError.saveError(error)))
            }
        }
    }
}

// MARK: - Private
extension CoreDataRecipesQueriesStorage {

    private func cleanUpQueries(for query: RecipeQuery, inContext context: NSManagedObjectContext) throws {
        let request: NSFetchRequest = RecipeQueryEntity.fetchRequest()
        var result = try context.fetch(request)

        removeDuplicates(for: query, in: &result, inContext: context)
        removeQueries(limit: maxStorageLimit - 1, in: result, inContext: context)
    }

    private func removeDuplicates(for query: RecipeQuery, in queries: inout [RecipeQueryEntity], inContext context: NSManagedObjectContext) {
        queries
            .filter { $0.query == query.query }
            .forEach { context.delete($0) }
        queries.removeAll { $0.query == query.query }
    }

    private func removeQueries(limit: Int, in queries: [RecipeQueryEntity], inContext context: NSManagedObjectContext) {
        guard queries.count > limit else { return }

        queries.suffix(queries.count - limit)
            .forEach { context.delete($0) }
    }
}
