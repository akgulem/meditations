//
//  File.swift
//  
//
//  Created by Emrah Akgül on 13.03.2021.
//

import Foundation

public struct MeditationDTO: Decodable {
    public let title: String?
    public let subtitle: String?
    public let image: ImageDTO?
    public let releaseDate: String?
    public let content: String?
}
