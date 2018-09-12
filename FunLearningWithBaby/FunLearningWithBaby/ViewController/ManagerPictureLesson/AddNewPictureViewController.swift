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
    
    // MARK: Action
    @IBAction func tappedAddNewPicture(_ sender: UIButton) {
        self.showActionSheet(titleArray: ["Mở camera","Chọn từ ảnh"], onTapped: { selectedTitle in
            if selectedTitle == "Mở camera" {
                Common.openCamera(controller: self)
            } else {
                Common.openGallary(controller: self)
            }
        })
    }
}

extension AddNewPictureViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    //UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.showActivityIndicator()
        self.dismiss(animated: true, completion: {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            guard let compressData = UIImageJPEGRepresentation(originalImage, 0.6) else {
                self.hideActivityIndicator()
                return
            }
            let compressImage = UIImage.init(data: compressData)
            self.newPictureImageView.image = compressImage
            // Write image to document
            self.hideActivityIndicator()
        })
    }
}
