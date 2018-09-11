//
//  BaseModel.swift
//  FunLearningWithBaby
//
//  Created by Hai Dang on 9/11/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    
    var image   = ""
    var vi_keys = ""
    var en_keys = ""
    
    func initBaseModel(model: [String : String]) {
        if model["image"] != nil {
            image   = model["image"]!
        }
        
        if model["vi_keys"] != nil {
            vi_keys = model["vi_keys"]!
        }
        
        if model["en_keys"] != nil {
            en_keys = model["en_keys"]!
        }
    }
}
