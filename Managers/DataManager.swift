//
//  DataManager.swift
//  CabeCare
//
//  Manages data persistence using UserDefaults
//

import Foundation

class DataManager {
    static let shared = DataManager()

    private let schedulesKey = "wateringSchedules"
    private let tipsKey = "plantTips"

    private init() {}

    // MARK: - Watering Schedules

    func saveSchedules(_ schedules: [WateringSchedule]) {
        if let encoded = try? JSONEncoder().encode(schedules) {
            UserDefaults.standard.set(encoded, forKey: schedulesKey)
        }
    }

    func loadSchedules() -> [WateringSchedule] {
        guard let data = UserDefaults.standard.data(forKey: schedulesKey),
              let schedules = try? JSONDecoder().decode([WateringSchedule].self, from: data) else {
            return []
        }
        return schedules
    }

    func addSchedule(_ schedule: WateringSchedule) {
        var schedules = loadSchedules()
        schedules.append(schedule)
        saveSchedules(schedules)
    }

    func updateSchedule(_ schedule: WateringSchedule) {
        var schedules = loadSchedules()
        if let index = schedules.firstIndex(where: { $0.id == schedule.id }) {
            schedules[index] = schedule
            saveSchedules(schedules)
        }
    }

    func deleteSchedule(_ schedule: WateringSchedule) {
        var schedules = loadSchedules()
        schedules.removeAll { $0.id == schedule.id }
        saveSchedules(schedules)
    }

    // MARK: - Plant Tips

    func saveTips(_ tips: [PlantTip]) {
        if let encoded = try? JSONEncoder().encode(tips) {
            UserDefaults.standard.set(encoded, forKey: tipsKey)
        }
    }

    func loadTips() -> [PlantTip] {
        guard let data = UserDefaults.standard.data(forKey: tipsKey),
              let tips = try? JSONDecoder().decode([PlantTip].self, from: data) else {
            return []
        }
        return tips
    }

    func addTip(_ tip: PlantTip) {
        var tips = loadTips()
        tips.insert(tip, at: 0) // Add to beginning
        saveTips(tips)
    }

    func deleteTip(_ tip: PlantTip) {
        var tips = loadTips()
        tips.removeAll { $0.id == tip.id }
        saveTips(tips)
    }
}
