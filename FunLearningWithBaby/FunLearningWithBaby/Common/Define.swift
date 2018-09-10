//
//  Define.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 3/5/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import Foundation
import UIKit

let app_delegate                = UIApplication.shared.delegate as! AppDelegate
let main_storyboard             = UIStoryboard(name: "Main", bundle: nil)
let comment_max                 = 1000
let title_max                   = 50

// MARK: - Size
let SCREEN_WIDTH                = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT               = UIScreen.main.bounds.size.height
let kBOTTOM_BAR_iPHONEX: CGFloat = 34.0
let kUUID                       = (UIDevice.current.identifierForVendor?.uuidString)!
// MARK: - Identifier
// App identifier
let APP_ID                      = "1188956958"

// Toast tag
let kIS_TOAST: Int = 243

// Admob
let kBannerAdUnitId             = "ca-app-pub-4981657393585558/2603567830"
let kInterstitialAdUnitID       = "ca-app-pub-4981657393585558/4986188592"
let kApplicationId              = "ca-app-pub-4981657393585558~3561426285"

// MARK: - Define Object

func IMAGE(_ imageName: String) -> UIImage {
    return UIImage(named: imageName) ?? UIImage()
}

//MARK: - Chat Type
let kALL_CHAT = 1
let kMY_CHAT = 2
let kHOT_CHAT = 3
let kFAVORITE_CHAT = 4
let kWEEK_CHAT = 5

//MARK: Baby Index
let weekArray = ["7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40"]

let bpdArray = ["","","","","","","21","25","29","32","36","39","43","46","50","53","56","59","62","65","68","71","73","76","78","81","83","85","87","89","90","92","93","94"]

let flArray = ["","","","","","","","14","17","20","23","25","28","31","34","36","39","42","44","47","49","52","54","56","59","61","63","65","67","68","70","71","73","74"]

let efwArray = ["0,5-2","1-3","3-5","5-7","12-15","18-25","35-50","60-80","90-110","121-171","150-212","185-261","227-319","275-387","399","478","568","679","785","913","1055","1210","1379","1559","1751","1953","2162","2377","2595","2813","3028","3236","3435","3619"]

let deviceNamesByCode: [String: String] =
                    ["i386"     : "Simulator",
                    "x86_64"    : "Simulator",
                    "iPod1,1"   : "iPod Touch",        // (Original)
                    "iPod2,1"   : "iPod Touch",        // (Second Generation)
                    "iPod3,1"   : "iPod Touch",        // (Third Generation)
                    "iPod4,1"   : "iPod Touch",        // (Fourth Generation)
                    "iPod7,1"   : "iPod Touch",        // (6th Generation)
                    "iPhone1,1" : "iPhone",            // (Original)
                    "iPhone1,2" : "iPhone",            // (3G)
                    "iPhone2,1" : "iPhone",            // (3GS)
                    "iPad1,1"   : "iPad",              // (Original)
                    "iPad2,1"   : "iPad 2",            //
                    "iPad3,1"   : "iPad",              // (3rd Generation)
                    "iPhone3,1" : "iPhone 4",          // (GSM)
                    "iPhone3,3" : "iPhone 4",          // (CDMA/Verizon/Sprint)
                    "iPhone4,1" : "iPhone 4S",         //
                    "iPhone5,1" : "iPhone 5",          // (model A1428, AT&T/Canada)
                    "iPhone5,2" : "iPhone 5",          // (model A1429, everything else)
                    "iPad3,4"   : "iPad",              // (4th Generation)
                    "iPad2,5"   : "iPad Mini",         // (Original)
                    "iPhone5,3" : "iPhone 5c",         // (model A1456, A1532 | GSM)
                    "iPhone5,4" : "iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                    "iPhone6,1" : "iPhone 5s",         // (model A1433, A1533 | GSM)
                    "iPhone6,2" : "iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                    "iPhone7,1" : "iPhone 6 Plus",     //
                    "iPhone7,2" : "iPhone 6",          //
                    "iPhone8,1" : "iPhone 6S",         //
                    "iPhone8,2" : "iPhone 6S Plus",    //
                    "iPhone8,4" : "iPhone SE",         //
                    "iPhone9,1" : "iPhone 7",          //
                    "iPhone9,3" : "iPhone 7",          //
                    "iPhone9,2" : "iPhone 7 Plus",     //
                    "iPhone9,4" : "iPhone 7 Plus",     //
                    "iPhone10,1": "iPhone 8",          // CDMA
                    "iPhone10,4": "iPhone 8",          // GSM
                    "iPhone10,2": "iPhone 8 Plus",     // CDMA
                    "iPhone10,5": "iPhone 8 Plus",     // GSM
                    "iPhone10,3": "iPhone X",          // CDMA
                    "iPhone10,6": "iPhone X",          // GSM
                    "iPad4,1"   : "iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                    "iPad4,2"   : "iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                    "iPad4,4"   : "iPad Mini",         // (2nd Generation iPad Mini - Wifi)
                    "iPad4,5"   : "iPad Mini",         // (2nd Generation iPad Mini - Cellular)
                    "iPad4,7"   : "iPad Mini",         // (3rd Generation iPad Mini - Wifi (model A1599))
                    "iPad6,7"   : "iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                    "iPad6,8"   : "iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                    "iPad6,3"   : "iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                    "iPad6,4"   : "iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
]
