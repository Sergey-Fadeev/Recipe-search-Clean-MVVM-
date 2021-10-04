//
//  RecipeQueryEntity+Mapping.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 04.10.2021.
//

import Foundation
import CoreData

extension RecipeQueryEntity {
    convenience init(recipeQuery: RecipeQuery, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        query = recipeQuery.query
    }
}

extension RecipeQueryEntity {
    func toDomain() -> RecipeQuery {
        return .init(query: query ?? "")
    }
}
