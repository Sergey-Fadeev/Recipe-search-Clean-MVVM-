//
//  RecipesResponseDTO+Mapping.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 30.09.2021.
//

import Foundation

// MARK: - Data Transfer Object

struct RecipesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case offset
        case number = "number"
        case totalResults = "totalResults"
        case recipes = "recipes"
    }
    let offset: Int
    let number: Int
    let recipes: [RecipeDTO]
    let totalResults: Int
}

extension RecipesResponseDTO {
    
    struct RecipeDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case title
            case image
            case imageType
        }
        
        let id: Int
        let title: String?
        let image: String?
        let imageType: ImageType?
    }
}

// MARK: - Mappings to Domain

extension RecipesResponseDTO {
    func toDomain() -> RecipesPage {
        return .init(recipes: recipes.map { $0.toDomain() }, offset: offset, number: number, totalResults: totalResults)
    }
}

extension RecipesResponseDTO.RecipeDTO {
    func toDomain() -> Recipe {
        return .init(id: Recipe.Identifier(id), title: title ?? "", image: image ?? "", imageType: imageType ?? ImageType.jpg)
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()

