//
//  SearchRecipesUseCases.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 29.09.2021.
//

import Foundation

protocol SearchRecipesUseCase {
    func execute(requestValue: SearchMoviesUseCaseRequestValue,
                 cached: @escaping (RecipesPage) -> Void,
                 completion: @escaping (Result<RecipesPage, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchMoviesUseCase: SearchRecipesUseCase {

    private let recipesRepository: RecipesRepository
    private let moviesQueriesRepository: RecipesQueriesRepository

    init(moviesRepository: RecipesRepository,
         moviesQueriesRepository: RecipesQueriesRepository) {

        self.recipesRepository = moviesRepository
        self.moviesQueriesRepository = moviesQueriesRepository
    }

    func execute(requestValue: SearchMoviesUseCaseRequestValue,
                 cached: @escaping (RecipesPage) -> Void,
                 completion: @escaping (Result<RecipesPage, Error>) -> Void) -> Cancellable? {

        return recipesRepository.fetchMoviesList(query: requestValue.query,
                                                page: requestValue.page,
                                                cached: cached,
                                                completion: { result in

            if case .success = result {
                self.moviesQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }

            completion(result)
        })
    }
}

struct SearchMoviesUseCaseRequestValue {
    let query: RecipeQuery
    let page: Int
}
