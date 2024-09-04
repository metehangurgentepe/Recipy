//
//  NetworkError.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import Foundation


enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError(String)
    case decodingError(Error)
    case invalidResponse
    case unknownStatusCode(Int)
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Bad Request (400): Unable to perform the request.", comment: "badRequestError")
            case .unauthorized:
                return NSLocalizedString("Unauthorized (401): Authentication is required.", comment: "unauthorizedError")
            case .forbidden:
                return NSLocalizedString("Forbidden (403): You don't have permission to access this resource.", comment: "forbiddenError")
            case .notFound:
                return NSLocalizedString("Not Found (404): The requested resource could not be found.", comment: "notFoundError")
            case .serverError(let errorMessage):
                return NSLocalizedString(errorMessage, comment: "serverError")
            case .decodingError:
                return NSLocalizedString("Unable to decode successfully.", comment: "decodingError")
            case .invalidResponse:
                return NSLocalizedString("Invalid response.", comment: "invalidResponse")
            case .unknownStatusCode(let statusCode):
                return NSLocalizedString("Unknown error with status code: \(statusCode).", comment: "unknownStatusCodeError")
        }
    }
}
