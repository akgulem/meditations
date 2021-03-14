//
//  DashboardViewInteractor.swift
//  Meditations
//
//  Created by Emrah Akgül on 13.03.2021.
//

import Foundation
import Meditations_Network

protocol DashboardViewInteractorInterface {
    func getDashboard()
}

protocol DashboardViewInteractorOutput: class {
    func handleGettingDashboard(result: Result<DashboardDTO?, ServiceError>)
}

final class DashboardViewInteractor {
    weak var output: DashboardViewInteractorOutput?
    var getDashboardService: GetDashboardServiceProtocol
    
    init(getDashboardService: GetDashboardServiceProtocol) {
        self.getDashboardService = getDashboardService
    }
}

extension DashboardViewInteractor: DashboardViewInteractorInterface {
    func getDashboard() {
        getDashboardService.getDashboard { [unowned self] (result) in
            self.output?.handleGettingDashboard(result: result)
        }
    }
}
