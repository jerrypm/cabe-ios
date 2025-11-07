//
//  ScheduleContract.swift
//  CabeCare
//
//  VIPER Contract for Schedule Module
//

import Foundation
import UIKit

// MARK: - View Protocol
protocol ScheduleViewProtocol: AnyObject {
    var presenter: SchedulePresenterProtocol? { get set }

    func showSchedules(_ schedules: [WateringSchedule])
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
    func didSelectSchedule(_ schedule: WateringSchedule)
    func didToggleSchedule(at index: Int, isEnabled: Bool)
    func didDeleteSchedule(at index: Int)
}

// MARK: - Interactor Protocol
protocol ScheduleInteractorProtocol: AnyObject {
    var presenter: ScheduleInteractorOutputProtocol? { get set }

    func fetchSchedules()
    func toggleSchedule(_ schedule: WateringSchedule, isEnabled: Bool)
    func deleteSchedule(_ schedule: WateringSchedule)
}

// MARK: - Interactor Output Protocol
protocol ScheduleInteractorOutputProtocol: AnyObject {
    func didFetchSchedules(_ schedules: [WateringSchedule])
    func didUpdateSchedule()
    func didDeleteSchedule()
    func didFailWithError(_ error: Error)
}

// MARK: - Router Protocol
protocol ScheduleRouterProtocol: AnyObject {
    static func createModule() -> UIViewController

    func navigateToAddSchedule(from view: ScheduleViewProtocol?)
    func navigateToEditSchedule(_ schedule: WateringSchedule, from view: ScheduleViewProtocol?)
}
