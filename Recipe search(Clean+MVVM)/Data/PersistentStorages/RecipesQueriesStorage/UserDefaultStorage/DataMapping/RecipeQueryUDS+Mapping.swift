//
//  RecipeQueryUDS+Mapping.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 04.10.2021.
//

import Foundation

struct RecipeQueriesListUDS: Codable {
    var list: [RecipeQueryUDS]
}

struct RecipeQueryUDS: Codable {
    let query: String
}

extension RecipeQueryUDS {
    init(movieQuery: RecipeQuery) {
        query = movieQuery.query
    }
}

extension RecipeQueryUDS {
    func toDomain() -> RecipeQuery {
        return .init(query: query)
    }
}
