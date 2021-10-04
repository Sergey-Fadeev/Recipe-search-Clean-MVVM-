//
//  ApiEndPoints.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 01.10.2021.
//

import Foundation

struct APIEndpoints {
    
    static func getRecipes(with recipesRequestDTO: RecipesRequestDTO) -> Endpoint<RecipesResponseDTO> {

        return Endpoint(path: "recipes/complexSearch/",
                        method: .get,
                        queryParametersEncodable: recipesRequestDTO)
    }
}
