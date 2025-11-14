//
//  CBPlantTip.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Model for plant care tips
//

import Foundation

struct CBPlantTip: Codable {
    let id: UUID
    var title: String
    var content: String
    var source: String?
    var dateAdded: Date

    init(id: UUID = UUID(), title: String, content: String, source: String? = nil, dateAdded: Date = Date()) {
        self.id = id
        self.title = title
        self.content = content
        self.source = source
        self.dateAdded = dateAdded
    }
}
