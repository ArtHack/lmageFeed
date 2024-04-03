
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
    case imagesList, profile
    
    var image: UIImage {
        switch self {
        case .imagesList:
            return .imagesListTabIcon
        case .profile:
            return .profile
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .imagesList:
            return ImagesListVC()
        case .profile:
            return ProfileVC()
        }
    }
}

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.contentMode = .scaleToFill
        view.backgroundColor = .clear
        
        configureTabBar()

    }
    
    private func configureTabBar() {
        let viewControllers = Tabs.allCases.map { tab in
            let viewController = tab.viewController
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.tabBarItem.image = tab.image
            
            UINavigationBar.appearance().isHidden = true
            
            let tabBarAppearance = UITabBar.appearance()
            tabBarAppearance.tintColor = .white
            tabBarAppearance.isTranslucent = false
            tabBarAppearance.backgroundColor = UIColor.IFColors.black
            tabBarAppearance.barTintColor = UIColor.IFColors.black
            
            return navigationController
        }
        setViewControllers(viewControllers, animated: true)
    }
}

