//
//  File.swift
//  
//
//  Created by Emrah Akgül on 13.03.2021.
//

import Foundation

public struct StoryDTO: Decodable {
    public let name: String?
    public let category: String?
    public let image: ImageDTO?
    public let date: String?
    public let text: String?
}
