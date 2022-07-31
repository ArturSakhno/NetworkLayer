//
//  File.swift
//  
//
//  Created by Artur Sakhno on 31.07.2022.
//

import Foundation

protocol NetworkInterface {
    func sendRequest<T: Decodable>(request: URLRequest, responseModel: T.Type) async -> Result<T, RequestError>
}

public final class Network: NetworkInterface {
    func sendRequest<T: Decodable>(request: URLRequest, responseModel: T.Type) async -> Result<T, RequestError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    return .success(decodedResponse)
                } catch {
                    return .failure(.decode)
                }
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

