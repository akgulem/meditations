//
//  File.swift
//  
//
//  Created by Emrah Akgül on 9.03.2021.
//

import Foundation

enum NetworkError: Swift.Error {
    enum Data: Swift.Error {
        case missing
        case read(underlying: DecodingError)
    }
    case corruptedURL
    case connection(reason: Swift.Error)
    case http(code: Int)
    case data(reason: Data)
    case other
}
