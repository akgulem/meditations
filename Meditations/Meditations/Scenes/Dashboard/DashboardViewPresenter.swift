//
//  DashboardViewPresenter.swift
//  Meditations
//
//  Created by Emrah Akgül on 13.03.2021.
//

import Foundation
import struct Meditations_UI.DashboardViewPresentation
import struct Meditations_UI.CardCollectionViewCellPresentation
import struct Meditations_UI.BannerPresentation
import struct Meditations_UI.MeditationDetailViewPresentation
import enum Meditations_Network.ServiceError
import struct Meditations_Network.DashboardDTO


protocol DashboardViewPresenterInterface: BasePresenterInterface, CollectionViewPresenterInterface {
    func shouldShowBannerView() -> Bool
    func cellPresentation(index: Int) -> CardCollectionViewCellPresentation?
    func selectItem(index: Int)
}

final class DashboardViewPresenter: DashboardViewPresenterInterface {
    
    var tag: Int!
    
    private weak var view: DashboardViewInterface?
    private let router: DashboardViewRouterInterface?
    private let interactor: DashboardViewInteractorInterface?
    
    private var dashboardDTO: DashboardDTO?
    private var dashboardPresentation: DashboardViewPresentation?
    private var collectionViewTag: Int!
    
    init(view: DashboardViewInterface?, router: DashboardViewRouterInterface?, interactor: DashboardViewInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    var numberOfItems: Int {
        guard let dashboardPresentation = self.dashboardPresentation else { return .zero }
        
        switch tag {
            case CollectionViewTag.meditations.rawValue:
                return dashboardPresentation.meditationPresentations?.count ?? .zero
            case CollectionViewTag.stories.rawValue:
                return dashboardPresentation.storyPresentations?.count ?? .zero
            default:
                return .zero
        }
    }
    
    
    func viewDidLoad() {
        view?.preparePageTitle()
        view?.prepareNavigationBar()
        view?.prepareBannerView()
        view?.prepareCollectionView()
        interactor?.getDashboard()
    }
    
    func cellPresentation(index: Int) -> CardCollectionViewCellPresentation? {
        switch tag {
            case CollectionViewTag.meditations.rawValue:
                return dashboardPresentation?.meditationPresentations?[index]
            case CollectionViewTag.stories.rawValue:
                return dashboardPresentation?.storyPresentations?[index]
            default:
                return nil
        }
    }
    
    func shouldShowBannerView() -> Bool {
        guard let _ = dashboardPresentation?.bannerPresentation else { return false }
        return true
    }
    
    func selectItem(index: Int) {
        var presentation:MeditationDetailViewPresentation? = nil
        switch tag {
            case CollectionViewTag.meditations.rawValue:
                guard let meditation = self.dashboardDTO?.meditations?[index] else { return }
                presentation = MeditationDetailViewPresentation(meditationDTO: meditation)
            case CollectionViewTag.stories.rawValue:
                guard let story = self.dashboardDTO?.stories?[index] else { return }
                presentation = MeditationDetailViewPresentation(storyDTO: story)
            default:
                return
        }
        router?.navigateToMeditationDetail(presentation: presentation)
    }
}


extension DashboardViewPresenter: DashboardViewInteractorOutput {
    func handleGettingDashboard(result: Result<DashboardDTO?, ServiceError>) {
        DispatchQueue.main.async { [unowned self] in
            switch result {
                case .success(let dashboardDTO):
                    guard let dashboardDTO = dashboardDTO else { return }
                    self.dashboardDTO = dashboardDTO
                    
                    var bannerPresentation: BannerPresentation? = nil
                    var meditationPresentations: [CardCollectionViewCellPresentation]? = nil
                    
                    if let isBannerEnabled = dashboardDTO.isBannerEnabled, isBannerEnabled {
                        bannerPresentation = BannerPresentation()
                    }
                    
                    if let meditations = dashboardDTO.meditations {
                        meditationPresentations = meditations.map { CardCollectionViewCellPresentation(meditationDTO: $0) }
                    }
                    
                    var storyPresentations: [CardCollectionViewCellPresentation]? = nil
                    if let stories = dashboardDTO.stories {
                        storyPresentations = stories.map {CardCollectionViewCellPresentation(storyDTO: $0) }
                    }
                    let dashboardViewPresentation = DashboardViewPresentation(bannerPresentation: bannerPresentation, meditationPresentations: meditationPresentations, storyPresentations: storyPresentations)
                    self.dashboardPresentation = dashboardViewPresentation
                    self.view?.handleBannerView()
                    self.view?.reloadCollectionView()
                   
                case .failure(let error):
                    print(error)
                    switch error {
                        case .wrongParameters:
                            break
                        case .notRetrieved:
                            break
                    }
            }
        }
    }
}
