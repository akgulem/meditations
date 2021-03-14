//
//  CardDetailViewPresentation.swift
//  Meditations_UI
//
//  Created by Emrah Akgül on 14.03.2021.
//

import Foundation
import Meditations_Network

private extension DateFormatter {
    private static var customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy, E"
        return formatter
    }()
    
    static func dateFromNumberString(numberString: String?) -> String? {
        guard let interval = TimeInterval(numberString ?? "") else { return nil }
        let date = Date(timeIntervalSince1970: interval)
        return DateFormatter.customDateFormatter.string(from: date)
    }
}

public struct MeditationDetailViewPresentation {
    public let title: String?
    public let detail: String?
    public let date: String?
    
    public init(meditationDTO: MeditationDTO?) {
        title = meditationDTO?.title
        detail = meditationDTO?.content
        date = DateFormatter.dateFromNumberString(numberString: meditationDTO?.releaseDate)
    }
    
    public init(storyDTO: StoryDTO?) {
        title = storyDTO?.name
        detail = storyDTO?.text
        date = DateFormatter.dateFromNumberString(numberString: storyDTO?.date)
    }

}
