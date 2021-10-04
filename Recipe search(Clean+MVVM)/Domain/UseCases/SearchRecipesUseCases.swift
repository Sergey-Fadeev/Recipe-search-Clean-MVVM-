//
//  SearchRecipesUseCases.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 29.09.2021.
//

import Foundation

protocol SearchRecipesUseCase {
    func execute(requestValue: SearchRecipesUseCaseRequestValue,
                 cached: @escaping (RecipesPage) -> Void,
                 completion: @escaping (Result<RecipesPage, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchRecipesUseCase: SearchRecipesUseCase {

    private let recipesRepository: RecipesRepository
    private let recipesQueriesRepository: RecipesQueriesRepository

    init(recipesRepository: RecipesRepository,
         recipesQueriesRepository: RecipesQueriesRepository) {

        self.recipesRepository = recipesRepository
        self.recipesQueriesRepository = recipesQueriesRepository
    }

    func execute(requestValue: SearchRecipesUseCaseRequestValue,
                 cached: @escaping (RecipesPage) -> Void,
                 completion: @escaping (Result<RecipesPage, Error>) -> Void) -> Cancellable? {

        return recipesRepository.fetchRecipesList(query: requestValue.query,
                                                page: requestValue.page,
                                                cached: cached,
                                                completion: { result in

            if case .success = result {
                self.recipesQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }

            completion(result)
        })
    }
}

struct SearchRecipesUseCaseRequestValue {
    let query: RecipeQuery
    let page: Int
}
