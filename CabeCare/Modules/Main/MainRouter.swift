//
//  MainRouter.swift
//  CabeCare
//
//  Main module router - Creates tab bar with VIPER modules
//

import UIKit

class MainRouter {

    static func createModule() -> UIViewController {
        let tabBarController = UITabBarController()

        // Schedule Tab - VIPER Module
        let scheduleVC = ScheduleRouter.createModule()
        scheduleVC.tabBarItem = UITabBarItem(
            title: "Jadwal",
            image: UIImage(systemName: "calendar"),
            selectedImage: UIImage(systemName: "calendar.fill")
        )

        // Tips Tab - Legacy (to be converted to VIPER)
        let tipsVC = TipsViewController()
        tipsVC.tabBarItem = UITabBarItem(
            title: "Tips",
            image: UIImage(systemName: "lightbulb"),
            selectedImage: UIImage(systemName: "lightbulb.fill")
        )

        tabBarController.viewControllers = [scheduleVC, tipsVC]
        tabBarController.tabBar.tintColor = .systemGreen

        return tabBarController
    }
}
