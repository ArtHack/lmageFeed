
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
