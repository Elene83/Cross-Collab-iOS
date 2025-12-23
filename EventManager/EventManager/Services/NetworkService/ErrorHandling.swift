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
