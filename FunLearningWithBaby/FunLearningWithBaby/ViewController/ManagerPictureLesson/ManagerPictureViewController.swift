//
//  NewLessonViewController.swift
//  FunLearningWithBaby
//
//  Created by Hai Dang on 9/11/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class ManagerPictureViewController: OriginalViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation Bar
    func setupNavigationBar() {
        self.addRightBarItem(imageName: "add", imageTouch: "add", title: "")
        self.addTitleNavigation(title: "Quản lý ảnh")
    }
    
    override func tappedRightBarButton(sender: UIButton) {
        let addNewPictureViewController = main_storyboard.instantiateViewController(withIdentifier: "AddNewPictureViewController") as! AddNewPictureViewController
        self.navigationController?.pushViewController(addNewPictureViewController, animated: true)
    }
    
    // MARK: UITableView delegate, datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureTableViewCell") as! PictureTableViewCell
        
        return cell
    }
}
