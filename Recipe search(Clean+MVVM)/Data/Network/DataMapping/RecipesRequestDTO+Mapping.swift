//
//  RecipesRequestDTO+Mapping.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 30.09.2021.
//

import Foundation

struct RecipesRequestDTO: Encodable {
    let query: String
    let page: Int
}
