//
//  MeditationDetailViewRouter.swift
//  Meditations
//
//  Created by Emrah Akgül on 14.03.2021.
//

import Foundation
import UIKit
import struct Meditations_UI.MeditationDetailViewPresentation

protocol MeditationDetailViewRouterInterface {}

final class MeditationDetailViewRouter {
    weak var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController: UINavigationController? = nil, presentation: MeditationDetailViewPresentation?) -> MeditationDetailViewController {
        let view = MeditationDetailViewController.initFromNib()
        let router = MeditationDetailViewRouter(with: navigationController)
        let interactor = MeditationDetailViewInteractor()
        
        let presenter = MeditationDetailViewPresenter(view: view, router: router, interactor: interactor, presentation: presentation)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension MeditationDetailViewRouter: MeditationDetailViewRouterInterface {}
