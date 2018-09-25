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
    @IBOutlet weak var microButton: UIButton!
    @IBOutlet weak var addNewPictureButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var keyTextField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Navigation Bar
    func setupNavigationBar() {
        self.addLeftBarItem(imageName: "back", title: "")
        self.addRightBarItem(imageName: "", imageTouch: "", title: "Save")
        self.addTitleNavigation(title: "Thêm ảnh")
    }
    
    // MARK: Set up UI
    func setupUI() {
        keyTextField.setupBorder(color: Common.mainColor())
        
        // Keyboard
        self.addKeyboardObserver()
        self.addTapGesture(view: view)
    }
    
    // MARK: Action
    
    // Navigation bar action
    override func tappedLeftBarButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tappedRightBarButton(sender: UIButton) {
        // Save new image
    }
    
    @IBAction func tappedAddNewPicture(_ sender: UIButton) {
        self.showActionSheet(titleArray: ["Mở camera","Chọn từ ảnh"], onTapped: { selectedTitle in
            if selectedTitle == "Mở camera" {
                Common.openCamera(controller: self)
            } else {
                Common.openGallary(controller: self)
            }
        })
    }
    
    @IBAction func tappedMicroPhone(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        SpeechViewController.shared.speechAction(isRecording: sender.isSelected, completionHandler: {(error,result) in
            self.keyTextField.text = result?.bestTranscription.formattedString
        })
    }
    
    // Keyboard
    override func showKeyboard(notification: NSNotification) {
        if let keyBoardSize = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue {
            scrollView.contentSize = CGSize.init(width: scrollView.frame.width, height: microButton.frame.origin.y + microButton.frame.height + keyBoardSize.cgRectValue.height + 10 - app_delegate.tabBarHeight)
            scrollView.contentOffset = CGPoint.init(x: 0, y: scrollView.contentSize.height - (microButton.frame.origin.y + microButton.frame.height))
        }
    }
    
    override func hideKeyboard(notification: NSNotification) {
        scrollView.contentOffset = CGPoint.init(x: 0, y: 0)

        scrollView.contentSize = CGSize.init(width: scrollView.frame.width, height: microButton.frame.origin.y + microButton.frame.height)
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
