//
//  HTTPError.swift
//  LogicEFT
//
//  Created by James Sayer on 7/8/21.
//

import Foundation

public enum HTTPError: Error {
    case nonHTTPResponse
    case requestFailed(Int)
    case serverError(Int)
    case networkError(Error)
    case custom(String)
    case decodingError(DecodingError)
}
