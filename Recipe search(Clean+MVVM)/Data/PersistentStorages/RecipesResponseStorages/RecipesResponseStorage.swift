//
//  RecipesResponseStorage.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 04.10.2021.
//

import Foundation

protocol RecipesResponseStorage {
    func getResponse(for request: RecipesRequestDTO, completion: @escaping (Result<RecipesResponseDTO?, CoreDataStorageError>) -> Void)
    func save(response: RecipesResponseDTO, for requestDto: RecipesRequestDTO)
}
