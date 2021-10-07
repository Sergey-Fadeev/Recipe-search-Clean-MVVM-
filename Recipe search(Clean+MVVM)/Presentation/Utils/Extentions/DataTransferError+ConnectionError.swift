//
//  DataTransferError+ConnectionError.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 07.10.2021.
//

import Foundation

extension DataTransferError: ConnectionError {
    public var isInternetConnectionError: Bool {
        guard case let DataTransferError.networkFailure(networkError) = self,
            case .notConnected = networkError else {
                return false
        }
        return true
    }
}
