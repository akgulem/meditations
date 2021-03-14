//
//  DashboardViewRouter.swift
//  Meditations
//
//  Created by Emrah Akgül on 13.03.2021.
//

import UIKit
import Meditations_UI


protocol DashboardViewRouterInterface {
    func navigateToMeditationDetail(presentation: MeditationDetailViewPresentation?)
}

final class DashboardViewRouter {
    weak var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController: UINavigationController? = nil) -> DashboardViewController {
        let view = DashboardViewController.initFromNib()
        let router = DashboardViewRouter(with: navigationController)
        let interactor = DashboardViewInteractor(getDashboardService: appDIContainer.getDashboardService)
        
        let presenter = DashboardViewPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }

}

extension DashboardViewRouter: DashboardViewRouterInterface {
    func navigateToMeditationDetail(presentation: MeditationDetailViewPresentation?) {
        let view = MeditationDetailViewRouter.createModule(using: navigationController, presentation: presentation)
        self.navigationController?.pushViewController(view, animated: true)
    }
}
