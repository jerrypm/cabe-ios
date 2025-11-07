//
//  AddScheduleRouter.swift
//  CabeCare
//
//  Router for AddSchedule module
//

import UIKit

class AddScheduleRouter {

    static func createModule(schedule: WateringSchedule?, delegate: AddScheduleDelegate?) -> UIViewController {
        let viewController = AddScheduleViewController()
        viewController.scheduleToEdit = schedule
        viewController.delegate = delegate
        return viewController
    }
}
