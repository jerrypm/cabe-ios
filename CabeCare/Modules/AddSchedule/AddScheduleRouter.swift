//
//  AddScheduleRouter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Router for AddSchedule module
//

import UIKit

class AddScheduleRouter {

    static func createModule(schedule: CBWateringSchedule?, delegate: AddScheduleDelegate?) -> UIViewController {
        let viewController = AddScheduleViewController()
        viewController.scheduleToEdit = schedule
        viewController.delegate = delegate
        return viewController
    }
}
