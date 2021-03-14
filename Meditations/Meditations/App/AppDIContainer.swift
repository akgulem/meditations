//
//  AppDIContainer.swift
//  Meditations
//
//  Created by Emrah Akgül on 13.03.2021.
//

import Foundation
import Meditations_Network

let appDIContainer = AppDIContainer()

final class AppDIContainer {
    let getDashboardService: GetDashboardServiceProtocol
    
    public init() {
        self.getDashboardService = GetDashboardAPIService(networkManageable: DefaultNetworkManager.default)
    }

}
