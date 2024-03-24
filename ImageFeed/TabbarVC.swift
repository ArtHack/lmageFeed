
//  TabbarVC.swift
//  ImageFeed
//
//  Created by Artem on 22.03.2024.

import UIKit

extension UIImage {
    static var imagesListTabIcon: UIImage {
        UIImage(named: "ImagesListActive")!
    }
    static var profile: UIImage {
        UIImage(named: "ProfileActive")!
    }
}

enum Tabs: String, CaseIterable {
    case imagesList, prifile
    
    var image: UIImage {
        switch self {
        case .imagesList:
            return .imagesListActive
        case .prifile:
            return .profileActive
        }
    }
}

final class TabBarController: UITabBarController {
    private func configure() {
        let viewControllers = Tabs.allCases.map { tab in
            let viewController = UIViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.tabBarItem.image = tab.image
            return navigationController
        }
        setViewControllers(viewControllers, animated: true)
    }
}
//final class TabBarController: UITabBarController {
//    private func configure() {
//        let viewControllers = Tabs.allCases.map { tab in
//            let viewController = UIViewController()
//            let navigationController = UINavigationController(rootViewController: ViewController)
//            navigationController.tabBarItem.title = tab.title
//            navigationController.tabBarItem.image = tab.image
//            return navigationController
//            setViewControllers(viewControllers, animated: true)
//        }
//    }
//}
//final class TabBarController: UITabBarController {
//private func configure() {
//let viewControllers = Tabs.allCases-map { tab in
//let viewController = UIViewController ()
//let navigationController = UINavigationController(rootViewController: viewController)
//navigationController.tabBarItem.title = tab.title
//navigationController.tabBarItem. image = UIImage(named: tab. imageName) ?? UIImage ( )
//return navigationController
//setViewControllers(viewControllers, animated: true)

//import UIKit
//
//extension UIImage {
//    static var overviewTabIcon: UIImage {
//        UIImage (named: "overviewTabIcon")!
//    }
//}
//enum Tabs: String, CaseIterable {
//    case overview session progress settings
//
//    var imageName: UIImage {
//        return "\(rawValue)TabIcon"
//    }
//
//
//    var image: UIImage {
//        switch self {
//        case .overview:
//            return .overviewTabIcon
//        case .progress:
//            return .progressTabIcon
//        case .session:
//            return .sessionTabIcon
//        case .settings:
//            return  .settingsTabIcon
//        }
//    }
//}
//
