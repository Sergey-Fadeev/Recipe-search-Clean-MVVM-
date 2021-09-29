//
//  Recipes.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 29.09.2021.
//

import Foundation

// MARK: - Recipes
struct RecipesPage: Codable {
    let recipes: [Recipe]
    let offset, number, totalResults: Int
}

// MARK: - Result
struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: ImageType
}

enum ImageType: String, Codable {
    case jpg = "jpg"
}
