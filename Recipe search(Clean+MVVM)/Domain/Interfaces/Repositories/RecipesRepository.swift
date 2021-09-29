//
//  RecipesRepository.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 29.09.2021.
//

import Foundation

protocol RecipesRepository {
    @discardableResult
    func fetchMoviesList(query: RecipeQuery, page: Int,
                         cached: @escaping (RecipesPage) -> Void,
                         completion: @escaping (Result<RecipesPage, Error>) -> Void) -> Cancellable?
}
