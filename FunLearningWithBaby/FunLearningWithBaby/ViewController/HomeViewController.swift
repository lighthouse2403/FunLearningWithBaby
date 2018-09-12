//
//  HomeViewController.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 4/4/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit

class HomeViewController: OriginalViewController{
    
    let tabController = MainTabBarViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Function
    func addChildViewController() {
        tabController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(tabController)
        self.view.addSubview(tabController.view)
        tabController.didMove(toParentViewController: self)

        app_delegate.tabBarHeight = tabController.tabBar.frame.height
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
