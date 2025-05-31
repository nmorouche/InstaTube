//
//  RequestError.swift
//  NetworkService
//
//  Created by Nassim Morouche on 30/05/2025.
//

/// The enum representing all error related to the request
public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
}
