//
//  File 2.swift
//  
//
//  Created by Artur Sakhno on 31.07.2022.
//

public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unexpectedStatusCode
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "No Response"
        case .unexpectedStatusCode:
            return "Unexpected Status Code"
        default:
            return "Unknown error"
        }
    }
}
