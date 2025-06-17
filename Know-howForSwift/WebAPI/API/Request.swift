//
//  Request.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/23.
//

import Foundation

protocol Request {
    associatedtype Response: Decodable
    var url: String { get }
    var params: [String: String] { get }
    var method: String { get }
    func request() async throws -> Response
}

extension Request {
    func request() async throws -> Response {

        var urlComponents = URLComponents(string: url)!  //URLComponentsでURLを生成
        if method == "GET" {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method
        if method != "GET" {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
        do {
            let task = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(Response.self, from: task.0)
            guard let urlResponse = task.1 as? HTTPURLResponse else {
                throw APIError.unknown
            }
            guard 200 ..< 300 ~= urlResponse.statusCode else {
                throw APIError.status(urlResponse.statusCode)
            }
            return response

        } catch {
            if let error = error as NSError? {
                if error.domain == NSURLErrorDomain, error.code == NSURLErrorTimedOut {
                    throw APIError.timeout
                }
            }
            throw APIError.other(error)
        }
    }
}
