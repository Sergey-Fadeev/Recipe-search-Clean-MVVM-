//
//  UseCase.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 29.09.2021.
//

import Foundation

public protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
