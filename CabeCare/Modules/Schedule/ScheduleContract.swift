//
//  ScheduleContract.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Contract for Schedule Module
//

import Foundation
import UIKit

// MARK: - View Protocol
protocol ScheduleViewProtocol: AnyObject {
    var presenter: SchedulePresenterProtocol? { get set }

    func showSchedules(_ schedules: [CBWateringSchedule])
    func showEmptyState()
    func hideEmptyState()
    func reloadData()
}

// MARK: - Presenter Protocol
protocol SchedulePresenterProtocol: AnyObject {
    var view: ScheduleViewProtocol? { get set }
    var interactor: ScheduleInteractorProtocol? { get set }
    var router: ScheduleRouterProtocol? { get set }

    func viewDidLoad()
    func viewWillAppear()
    func didTapAddSchedule()
    func didSelectSchedule(_ schedule: CBWateringSchedule)
    func didToggleSchedule(at index: Int, isEnabled: Bool)
    func didDeleteSchedule(at index: Int)
}

// MARK: - Interactor Protocol
protocol ScheduleInteractorProtocol: AnyObject {
    var presenter: ScheduleInteractorOutputProtocol? { get set }

    func fetchSchedules()
    func toggleSchedule(_ schedule: CBWateringSchedule, isEnabled: Bool)
    func deleteSchedule(_ schedule: CBWateringSchedule)
}

// MARK: - Interactor Output Protocol
protocol ScheduleInteractorOutputProtocol: AnyObject {
    func didFetchSchedules(_ schedules: [CBWateringSchedule])
    func didUpdateSchedule()
    func didDeleteSchedule()
    func didFailWithError(_ error: Error)
}

// MARK: - Router Protocol
protocol ScheduleRouterProtocol: AnyObject {
    static func createModule() -> UIViewController

    func navigateToAddSchedule(from view: ScheduleViewProtocol?)
    func navigateToEditSchedule(_ schedule: CBWateringSchedule, from view: ScheduleViewProtocol?)
}
