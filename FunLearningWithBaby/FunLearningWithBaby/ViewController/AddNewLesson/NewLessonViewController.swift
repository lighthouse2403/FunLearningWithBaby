//
//  NewLessonViewController.swift
//  FunLearningWithBaby
//
//  Created by Hai Dang on 9/11/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class NewLessonViewController: OriginalViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupNavigationBar() {
        self.addRightBarItem(imageName: "", imageTouch: "", title: "")
        self.addTitleNavigation(title: "Thêm ảnh")
    }
}
