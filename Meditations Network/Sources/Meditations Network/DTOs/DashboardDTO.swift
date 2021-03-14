//
//  File.swift
//  
//
//  Created by Emrah Akgül on 13.03.2021.
//

import Foundation

public struct DashboardDTO: Decodable {
    public let isBannerEnabled: Bool?
    public let meditations: [MeditationDTO]?
    public let stories: [StoryDTO]?
}
