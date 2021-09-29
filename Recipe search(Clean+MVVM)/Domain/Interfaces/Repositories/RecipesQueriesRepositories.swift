//
//  RecipesQueriesRepositories.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 29.09.2021.
//

import Foundation

protocol MoviesQueriesRepository {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[RecipeQuery], Error>) -> Void)
    func saveRecentQuery(query: RecipeQuery, completion: @escaping (Result<RecipeQuery, Error>) -> Void)
}
