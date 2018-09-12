//
//  AddNewPictureViewController.swift
//  FunLearningWithBaby
//
//  Created by Hai Dang on 9/12/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class AddNewPictureViewController: OriginalViewController {

    @IBOutlet weak var newPictureImageView: UIImageView!
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var microButton: UIButton!
    @IBOutlet weak var addNewPictureButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Navigation Bar
    func setupNavigationBar() {
        self.addLeftBarItem(imageName: "back", title: "")
        self.addTitleNavigation(title: "Thêm ảnh")
    }
    
    override func tappedLeftBarButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
