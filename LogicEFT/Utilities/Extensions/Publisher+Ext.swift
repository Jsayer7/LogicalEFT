//
//  Publisher+Ext.swift
//  LogicEFT
//
//  Created by James Sayer on 7/8/21.
//

import Foundation
import Combine

public extension Publisher where Output == (data: Data, response: URLResponse) {
    // Convert the response tuple of URLSession's dataTask from (data: Data, response: URLResponse) to (data: Data, response: HTTPURLResponse). Lets us check the http status code down the line.
    
    /// Get proper HTTP response from URLSession's dataTask function.
    func assumeHTTP() -> AnyPublisher<(data: Data, response: HTTPURLResponse), HTTPError> {
        tryMap { (data: Data, response: URLResponse) in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.nonHTTPResponse
            }
            
            return (data, httpResponse)
        }
        .mapError { error in
            if error is HTTPError {
                return error as! HTTPError
            } else {
                return HTTPError.networkError(error)
            }
        }
        .eraseToAnyPublisher()
    }
}

public extension Publisher where Output == (data: Data, response: HTTPURLResponse) {
    func responseData() -> AnyPublisher<Data, HTTPError> {
        tryMap { (data: Data, response: HTTPURLResponse) in
            switch response.statusCode {
            case 200:
                return data
            case 400...499:
                throw HTTPError.requestFailed(response.statusCode)
            case 500...599:
                throw HTTPError.serverError(response.statusCode)
            default:
                throw HTTPError.custom("Received an unhandled HTTP Response Status Code: \(response.statusCode)")
            }
        }
        .mapError { $0 as! HTTPError }
        .eraseToAnyPublisher()
    }
}

public extension Publisher where Output == Data, Failure == HTTPError {
    func decoding<Item, Coder>(type: Item.Type, decoder: Coder) -> AnyPublisher<Item, HTTPError> where Item: Decodable, Coder: TopLevelDecoder, Self.Output == Coder.Input {
        decode(type: type, decoder: decoder)
            .mapError { error in
                if error is DecodingError {
                    return HTTPError.decodingError(error as! DecodingError)
                } else {
                    return error as! HTTPError
                }
            }
            .eraseToAnyPublisher()
    }
}
