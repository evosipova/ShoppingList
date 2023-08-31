//
//  RequestProcessor.swift
//  ShoppingList
//
//  Created by Elizabeth on 31.08.2023.
//

import Foundation

enum RequestProcessor {
    static func makeURL(from id: String? = nil) throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        if let id {
            components.path = "/" + internPath + "/" + detailPath + "/" + id + jsonPath
        } else {
            components.path = "/" + internPath + "/" + mainPath + jsonPath
        }
        guard let url = components.url else {
            throw RequestProcessorErrors.wrongURL(components)
        }
        return url
    }
    
    static func performRequest(with url: URL) async throws -> (Data, HTTPURLResponse) {
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethods.get.rawValue
        let (data, response) = try await session.data(for: request)
        guard let httpURLResponse = response.httpURLResponse else {
            throw RequestProcessorErrors.unexpectedResponse(response)
        }
        guard httpURLResponse.isSuccessful else {
            throw RequestProcessorErrors.requestFailed(httpURLResponse)
        }
        return (data, httpURLResponse)
    }
    
    enum httpMethods: String {
        case get = "GET"
    }
    
    enum RequestProcessorErrors: Error {
        case wrongURL(URLComponents)
        case unexpectedResponse(URLResponse)
        case requestFailed(HTTPURLResponse)
    }
}

extension URLResponse {
    var httpURLResponse: HTTPURLResponse? {
        self as? HTTPURLResponse
    }
}

extension HTTPURLResponse {
    var isSuccessful: Bool {
        200 ... 299 ~= statusCode
    }
}

private let scheme = "https"
private let host = "www.avito.st"
private let mainPath = "main-page"
private let internPath = "s/interns-ios"
private let detailPath = "details"
private let jsonPath = ".json"

