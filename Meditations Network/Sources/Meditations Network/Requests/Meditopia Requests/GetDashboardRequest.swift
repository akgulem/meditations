//
//  File.swift
//  
//
//  Created by Emrah Akgül on 7.03.2021.
//

import Foundation

struct GetDashboardRequest: GetRequest {
    var path: String = "/api/jsonBlob/a07152f5-775c-11eb-a533-c90b9d55001f"
    var parameters: [URLQueryItem]? = nil
    var headers: [String : String] = [:]
}
