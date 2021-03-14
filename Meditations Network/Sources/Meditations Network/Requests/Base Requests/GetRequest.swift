//
//  File.swift
//  
//
//  Created by Emrah Akgül on 7.03.2021.
//

import Foundation

protocol GetRequest: Request {}

extension GetRequest {
    var method: HTTPMethod {
        return .GET
    }
    
    var body: Data?  {
        return nil
    }
}
