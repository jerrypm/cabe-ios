//
//  CBWateringSchedule.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Model for watering schedule
//

import Foundation

struct CBWateringSchedule: Codable {
    let id: UUID
    var plantName: String
    var wateringTime: Date
    var repeatInterval: RepeatInterval
    var isEnabled: Bool
    var notes: String?

    enum RepeatInterval: String, Codable, CaseIterable {
        case daily = "Setiap Hari"
        case twiceDaily = "2x Sehari"
        case everyTwoDays = "2 Hari Sekali"
        case everyThreeDays = "3 Hari Sekali"
        case weekly = "Seminggu Sekali"

        var timeInterval: TimeInterval {
            switch self {
            case .daily:
                return 24 * 60 * 60
            case .twiceDaily:
                return 12 * 60 * 60
            case .everyTwoDays:
                return 2 * 24 * 60 * 60
            case .everyThreeDays:
                return 3 * 24 * 60 * 60
            case .weekly:
                return 7 * 24 * 60 * 60
            }
        }
    }

    init(id: UUID = UUID(), plantName: String, wateringTime: Date, repeatInterval: RepeatInterval, isEnabled: Bool = true, notes: String? = nil) {
        self.id = id
        self.plantName = plantName
        self.wateringTime = wateringTime
        self.repeatInterval = repeatInterval
        self.isEnabled = isEnabled
        self.notes = notes
    }
}
