//
//  AddScheduleContract.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Contract for AddSchedule Module
//

import Foundation
import UIKit

// MARK: - Delegate Protocol
protocol CBAddScheduleDelegate: AnyObject {
    func didAddSchedule(_ schedule: CBWateringSchedule)
    func didUpdateSchedule(_ schedule: CBWateringSchedule)
}

// MARK: - View Protocol
protocol CBAddScheduleViewProtocol: AnyObject {
    var presenter: CBAddSchedulePresenterProtocol? { get set }

    func showScheduleData(plantName: String, time: Date, interval: CBWateringSchedule.RepeatInterval, notes: String?)
    func showValidationError(message: String)
    func dismissView()
}

// MARK: - Presenter Protocol
protocol CBAddSchedulePresenterProtocol: AnyObject {
    var view: CBAddScheduleViewProtocol? { get set }
    var interactor: CBAddScheduleInteractorProtocol? { get set }
    var router: CBAddScheduleRouterProtocol? { get set }

    func viewDidLoad()
    func didTapCancel()
    func didTapSave(plantName: String?, time: Date, interval: CBWateringSchedule.RepeatInterval, notes: String?)
}

// MARK: - Interactor Protocol
protocol CBAddScheduleInteractorProtocol: AnyObject {
    var presenter: CBAddScheduleInteractorOutputProtocol? { get set }
    var scheduleToEdit: CBWateringSchedule? { get set }

    func getScheduleToEdit() -> CBWateringSchedule?
    func saveSchedule(plantName: String, time: Date, interval: CBWateringSchedule.RepeatInterval, notes: String?)
    func updateSchedule(plantName: String, time: Date, interval: CBWateringSchedule.RepeatInterval, notes: String?)
}

// MARK: - Interactor Output Protocol
protocol CBAddScheduleInteractorOutputProtocol: AnyObject {
    func didSaveSchedule(_ schedule: CBWateringSchedule)
    func didUpdateSchedule(_ schedule: CBWateringSchedule)
    func didFailValidation(message: String)
}

// MARK: - Router Protocol
protocol CBAddScheduleRouterProtocol: AnyObject {
    static func createModule(schedule: CBWateringSchedule?, delegate: CBAddScheduleDelegate?) -> UIViewController

    func dismissModule(from view: CBAddScheduleViewProtocol?)
}
