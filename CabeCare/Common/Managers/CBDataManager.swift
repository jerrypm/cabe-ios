//
//  CBDataManager.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Manages data persistence using UserDefaults
//

import Foundation

class CBDataManager {
    static let shared = CBDataManager()

    private let schedulesKey = "wateringSchedules"
    private let tipsKey = "plantTips"

    private init() {}

    // MARK: - Watering Schedules

    func saveSchedules(_ schedules: [CBWateringSchedule]) {
        if let encoded = try? JSONEncoder().encode(schedules) {
            UserDefaults.standard.set(encoded, forKey: schedulesKey)
        }
    }

    func loadSchedules() -> [CBWateringSchedule] {
        guard let data = UserDefaults.standard.data(forKey: schedulesKey),
              let schedules = try? JSONDecoder().decode([CBWateringSchedule].self, from: data) else {
            return []
        }
        return schedules
    }

    func addSchedule(_ schedule: CBWateringSchedule) {
        var schedules = loadSchedules()
        schedules.append(schedule)
        saveSchedules(schedules)
    }

    func updateSchedule(_ schedule: CBWateringSchedule) {
        var schedules = loadSchedules()
        if let index = schedules.firstIndex(where: { $0.id == schedule.id }) {
            schedules[index] = schedule
            saveSchedules(schedules)
        }
    }

    func deleteSchedule(_ schedule: CBWateringSchedule) {
        var schedules = loadSchedules()
        schedules.removeAll { $0.id == schedule.id }
        saveSchedules(schedules)
    }

    // MARK: - Plant Tips

    func saveTips(_ tips: [CBPlantTip]) {
        if let encoded = try? JSONEncoder().encode(tips) {
            UserDefaults.standard.set(encoded, forKey: tipsKey)
        }
    }

    func loadTips() -> [CBPlantTip] {
        guard let data = UserDefaults.standard.data(forKey: tipsKey),
              let tips = try? JSONDecoder().decode([CBPlantTip].self, from: data) else {
            return []
        }
        return tips
    }

    func addTip(_ tip: CBPlantTip) {
        var tips = loadTips()
        tips.insert(tip, at: 0) // Add to beginning
        saveTips(tips)
    }

    func deleteTip(_ tip: CBPlantTip) {
        var tips = loadTips()
        tips.removeAll { $0.id == tip.id }
        saveTips(tips)
    }
}
