//
//  APIError.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/23.
//

enum APIError: Error {
    case status(Int)
    case other(Error)
    case unknown
}
