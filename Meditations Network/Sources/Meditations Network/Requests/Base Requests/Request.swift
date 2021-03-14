//
//  File.swift
//  
//
//  Created by Emrah Akgül on 7.03.2021.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public protocol Request {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get set }
    var headers: [String: String] { get }
    var body: Data? { get }
    var constructedURL: URL? {get}
}

extension Request {
    public var constructedURL: URL? {
        var components = URLComponents()
        let scheme = Bundle.main.object(forInfoDictionaryKey: "URL_SCHEME") as! String
        let host = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = parameters
        return components.url
    }
}
