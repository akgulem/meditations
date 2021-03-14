//
//  DashboardViewPresentation.swift
//  Meditations_UI
//
//  Created by Emrah Akgül on 13.03.2021.
//

import Foundation

public struct DashboardViewPresentation {
    public let bannerPresentation: BannerPresentation?
    public let meditationPresentations: [CardCollectionViewCellPresentation]?
    public let storyPresentations: [CardCollectionViewCellPresentation]?
    
    
    public init(bannerPresentation: BannerPresentation?, meditationPresentations: [CardCollectionViewCellPresentation]?,storyPresentations: [CardCollectionViewCellPresentation]? ) {
        self.bannerPresentation = bannerPresentation
        self.meditationPresentations = meditationPresentations
        self.storyPresentations = storyPresentations
    }
}
