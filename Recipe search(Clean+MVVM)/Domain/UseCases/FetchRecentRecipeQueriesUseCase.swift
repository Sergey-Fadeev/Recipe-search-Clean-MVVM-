//
//  FetchRecentRecipeQueriesUseCase.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 29.09.2021.
//

import Foundation

// This is another option to create Use Case using more generic way
final class FetchRecentRecipeQueriesUseCase: UseCase {

    struct RequestValue {
        let maxCount: Int
    }
    typealias ResultValue = (Result<[RecipeQuery], Error>)

    private let requestValue: RequestValue
    private let completion: (ResultValue) -> Void
    private let recipesQueriesRepository: RecipesQueriesRepository

    init(requestValue: RequestValue,
         completion: @escaping (ResultValue) -> Void,
         recipesQueriesRepository: RecipesQueriesRepository) {

        self.requestValue = requestValue
        self.completion = completion
        self.recipesQueriesRepository = recipesQueriesRepository
    }
    
    func start() -> Cancellable? {

        recipesQueriesRepository.fetchRecentsQueries(maxCount: requestValue.maxCount, completion: completion)
        return nil
    }
}
