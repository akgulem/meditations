//
//  File.swift
//  
//
//  Created by Emrah Akgül on 7.03.2021.
//

import Foundation

public protocol GetDashboardServiceProtocol {
    func getDashboard(completion: @escaping (Result<DashboardDTO?, ServiceError>) -> Void)
}

