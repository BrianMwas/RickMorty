//
//  ViewController.swift
//  RickMorty
//
//  Created by Brian on 15/03/2023.
//

import UIKit

/// Adds controls to screens embedded in the bottom nav bar.
final class RMTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpTabs()
    }

    private func setUpTabs() {
        let characterVC = RMCharacterController()
        let episodeVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()
        let locationVC = RMLocationViewController()
        
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: characterVC)
        let nav2 = UINavigationController(rootViewController: episodeVC)
        let nav3 = UINavigationController(rootViewController: locationVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "globe"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}

