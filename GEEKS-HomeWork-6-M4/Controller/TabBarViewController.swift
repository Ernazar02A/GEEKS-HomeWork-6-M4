//
//  TabBarViewController.swift
//  GEEKS-HomeWork-6-M4
//
//  Created by MacBook Pro on 1/6/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLayoutSubviews() {
        tabBar.frame = CGRect(x: 20,
                              y: self.view.frame.height - 100,
                              width: tabBar.frame.size.width - 40,
                              height: tabBar.frame.size.height - 5)
    }
}
