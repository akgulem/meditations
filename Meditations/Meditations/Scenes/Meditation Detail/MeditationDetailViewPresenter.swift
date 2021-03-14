//
//  MeditationDetailViewPresentation.swift
//  Meditations
//
//  Created by Emrah Akgül on 14.03.2021.
//

import Foundation
import struct Meditations_UI.MeditationDetailViewPresentation

protocol MeditationDetailViewPresenterInterface: BasePresenterInterface {
    func getPresentation() -> MeditationDetailViewPresentation?
}

final class MeditationDetailViewPresenter {
    private weak var view: MeditationDetailViewInterface?
    private let router: MeditationDetailViewRouterInterface?
    private let interactor: MeditationDetailViewInteractorInterface?
    
    private var presentation: MeditationDetailViewPresentation?
    
    init(view: MeditationDetailViewInterface?, router: MeditationDetailViewRouterInterface?, interactor: MeditationDetailViewInteractorInterface?, presentation:MeditationDetailViewPresentation? = nil ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.presentation = presentation
    }
    
}


extension MeditationDetailViewPresenter: MeditationDetailViewPresenterInterface {
    func getPresentation() -> MeditationDetailViewPresentation? {
        return presentation
    }
    
    func viewDidLoad() {
        view?.prepareNavigationBar()
        view?.preparePageBody()
    }
}

extension MeditationDetailViewPresenter: MeditationDetailViewInteractorOutput {}
