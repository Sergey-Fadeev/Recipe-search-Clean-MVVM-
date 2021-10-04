//
//  UserDefaultsRecipesQueriesStorage.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 04.10.2021.
//

import Foundation

final class UserDefaultsRecipesQueriesStorage {
    private let maxStorageLimit: Int
    private let recentsMoviesQueriesKey = "recentsRecipesQueries"
    private var userDefaults: UserDefaults
    
    init(maxStorageLimit: Int, userDefaults: UserDefaults = UserDefaults.standard) {
        self.maxStorageLimit = maxStorageLimit
        self.userDefaults = userDefaults
    }

    private func fetchMoviesQuries() -> [RecipeQuery] {
        if let queriesData = userDefaults.object(forKey: recentsMoviesQueriesKey) as? Data {
            if let movieQueryList = try? JSONDecoder().decode(RecipeQueriesListUDS.self, from: queriesData) {
                return movieQueryList.list.map { $0.toDomain() }
            }
        }
        return []
    }

    private func persist(moviesQuries: [RecipeQuery]) {
        let encoder = JSONEncoder()
        let movieQueryUDSs = moviesQuries.map(RecipeQueryUDS.init)
        if let encoded = try? encoder.encode(RecipeQueriesListUDS(list: movieQueryUDSs)) {
            userDefaults.set(encoded, forKey: recentsMoviesQueriesKey)
        }
    }
}

extension UserDefaultsRecipesQueriesStorage: RecipesQueriesStorage {

    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[RecipeQuery], Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }

            var queries = self.fetchMoviesQuries()
            queries = queries.count < self.maxStorageLimit ? queries : Array(queries[0..<maxCount])
            completion(.success(queries))
        }
    }

    func saveRecentQuery(query: RecipeQuery, completion: @escaping (Result<RecipeQuery, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }

            var queries = self.fetchMoviesQuries()
            self.cleanUpQueries(for: query, in: &queries)
            queries.insert(query, at: 0)
            self.persist(moviesQuries: queries)

            completion(.success(query))
        }
    }
}


// MARK: - Private
extension UserDefaultsRecipesQueriesStorage {

    private func cleanUpQueries(for query: RecipeQuery, in queries: inout [RecipeQuery]) {
        removeDuplicates(for: query, in: &queries)
        removeQueries(limit: maxStorageLimit - 1, in: &queries)
    }

    private func removeDuplicates(for query: RecipeQuery, in queries: inout [RecipeQuery]) {
        queries = queries.filter { $0 != query }
    }

    private func removeQueries(limit: Int, in queries: inout [RecipeQuery]) {
        queries = queries.count <= limit ? queries : Array(queries[0..<limit])
    }
}
