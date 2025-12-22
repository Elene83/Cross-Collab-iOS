//
//  ErrorHandling.swift
//  EventManager
//
//  Created by Atinati on 22.12.25.
//

import Foundation

@MainActor
protocol ErrorHandling: AnyObject {
    var errorMessage: String? { get set }
}

extension ErrorHandling {
    func handleError(_ error: Error) {
        if let apiError = error as? APIError {
            errorMessage = apiError.localizedDescription
        } else {
            errorMessage = error.localizedDescription
        }
    }
}
