//
//  RecipesResponseEntity+Mapping.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 04.10.2021.
//

import Foundation
import CoreData

extension RecipesResponseEntity {
    func toDTO() -> RecipesResponseDTO {
        return .init(offset: Int(offset), number: Int(number), recipes: recipes?.allObjects.map { ($0 as! RecipeResponseEntity).toDTO() } ?? [], totalResults: Int(totalResults))
    }
}

extension RecipeResponseEntity {
    func toDTO() -> RecipesResponseDTO.RecipeDTO {
        return .init(id: Int(id), title: title, image: image, imageType: ImageType.jpg )
    }
}

extension RecipesRequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> RecipesRequestEntity {
        let entity: RecipesRequestEntity = .init(context: context)
        entity.query = query
        return entity
    }
}

extension RecipesResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> RecipesResponseEntity {
        let entity: RecipesResponseEntity = .init(context: context)
        entity.number = Int32(number)
        entity.offset = Int32(offset)
        entity.totalResults = Int32(totalResults)
        recipes.forEach {
            entity.addToRecipes($0.toEntity(in: context))
        }
        
        entity.number = Int32(number)
        entity.offset = Int32(offset)
        entity.totalResults = Int32(totalResults)
        
        
        recipes.forEach {
            entity.addToRecipes($0.toEntity(in: context))
        }
        return entity
    }
}

extension RecipesResponseDTO.RecipeDTO {
    func toEntity(in context: NSManagedObjectContext) -> RecipeResponseEntity {
        let entity: RecipeResponseEntity = .init(context: context)
        entity.id = Int64(id)
        entity.title = title
        entity.image = image
        entity.imageType = imageType?.rawValue
        return entity
    }
}
