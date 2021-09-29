//
//  ConnectionError.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 29.09.2021.
//

import Foundation

public protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

public extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}
