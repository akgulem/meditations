//
//  File.swift
//  
//
//  Created by Emrah Akgül on 7.03.2021.
//

import Foundation

public final class GetDashboardAPIService: GetDashboardServiceProtocol {
    let networkManageable: NetworkManageable
    
    public init(networkManageable: NetworkManageable) {
        self.networkManageable = networkManageable
    }
    
    public func getDashboard(completion: @escaping (Result<DashboardDTO?, ServiceError>) -> Void) {
        let getDashboardRequest = GetDashboardRequest()
        networkManageable.makeRequest(request: getDashboardRequest) { (dashboardDTO: DashboardDTO?, error: Error?) in
            if let error = error {
                print(error)
                completion(.failure(ServiceError.notRetrieved))
                return
            }
            if let dashboardDTO = dashboardDTO {
                completion(.success(dashboardDTO))
            }
            else {
                completion(.failure(ServiceError.notRetrieved))
            }
        }
    }
}
