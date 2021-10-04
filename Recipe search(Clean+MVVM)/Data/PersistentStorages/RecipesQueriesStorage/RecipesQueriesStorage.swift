//
//  MoviesQueriesStorage.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 04.10.2021.
//

import Foundation

protocol RecipesQueriesStorage {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[RecipeQuery], Error>) -> Void)
    func saveRecentQuery(query: RecipeQuery, completion: @escaping (Result<RecipeQuery, Error>) -> Void)
}
