//
//  CardCollectionViewCellPresentation.swift
//  Meditations_UI
//
//  Created by Emrah Akgül on 13.03.2021.
//

import Foundation
import Meditations_Network

public struct CardCollectionViewCellPresentation {
    let smallImage: String?
    let largeImage: String?
    let title: String?
    let detail: String?
    
    public init(meditationDTO: MeditationDTO?) {
        self.smallImage = meditationDTO?.image?.small
        self.largeImage = meditationDTO?.image?.large
        self.title = meditationDTO?.title
        self.detail = meditationDTO?.subtitle
    }
    
    public init(storyDTO: StoryDTO?) {
        self.smallImage = storyDTO?.image?.small
        self.largeImage = storyDTO?.image?.large
        self.title = storyDTO?.name
        self.detail = storyDTO?.category
    }
}
