//
//  FirebaseAction.swift
//  LocationTracking
//
//  Created by Nguyen Hai Dang on 6/17/17.
//  Copyright © 2017 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class FirebaseAction: NSObject {
    
    lazy var ref: DatabaseReference = Database.database().reference()

    func initFirebase() {
        FirebaseApp.configure()
        Database.database().reference()
        GADMobileAds.configure(withApplicationID: kApplicationId)
    }
    
    func getTimestamp() {
        let serverTimestamp = ServerValue.timestamp()
        var resultRef: DatabaseReference = Database.database().reference()

        resultRef = ref.child("discuss").child("threads")
        //comform to waiting share property
        resultRef.childByAutoId().setValue(serverTimestamp)
    }
    
    //MARK: - USERS
    
    func updateNickName() {
        var motherName = "Ẩn danh"
        if UserDefaults.standard.object(forKey: "motherName") != nil {
            motherName = UserDefaults.standard.object(forKey: "motherName") as! String
        }
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("users")
        //comform to waiting share property
    resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).setValue(motherName)
    }
    
    func updateUserStatus() {
        let serverTimestamp = ServerValue.timestamp()
        var motherName = "Ẩn danh"
        if UserDefaults.standard.object(forKey: "motherName") != nil {
            motherName = UserDefaults.standard.object(forKey: "motherName") as! String
        }
        var babyName = "Ẩn danh"
        if UserDefaults.standard.object(forKey: "babyName") != nil {
            babyName = UserDefaults.standard.object(forKey: "babyName") as! String
        }
        
        let deviceName = deviceNamesByCode[UIDevice.current.modelName] ?? "New Device"
        //comform to waiting share property
        ref.child("activeUser").child((UIDevice.current.identifierForVendor?.uuidString)!).setValue(["name": motherName,"baby": babyName,"lastOnlineTime": serverTimestamp,"device": deviceName,"id": (UIDevice.current.identifierForVendor?.uuidString)!])
    }
    
    func getUser(max: NSInteger, onCompletionHandler: @escaping ([String : String]) -> ()) {
        ref.child("users").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : String] ?? [:]
        
            onCompletionHandler(snapDict)
        })
    }
    
    func getActiveUser(max: NSInteger, onCompletionHandler: @escaping ([String : String]) -> ()) {
        ref.child("activeUser").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : String] ?? [:]
            
            onCompletionHandler(snapDict)
        })
    }
    
    //MARK: - THREADS
    
    /**
    Create new thread
     - title: title of question which display at chat list
     - content: question of user
     **/
    func createNewThread(title: String, content: String, onCompletionHandler: @escaping () -> ()) {
        //comform to contact id
        let serverTimestamp = ServerValue.timestamp()
        
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("discuss").child("threads")
        //comform to waiting share property
        resultRef.childByAutoId().setValue(["title": title, "content": content, "userName": (UIDevice.current.identifierForVendor?.uuidString)!,"time": serverTimestamp, "lastComment": serverTimestamp])
        onCompletionHandler()
    }
    
    /**
     Edit thread
     - threadId: id of thread which user want to edit
     - newTitle: new title which user want to change
     **/
    func editThread(threadId: String, newTitle: String) {
        ref.child("discuss").child("threads").child(threadId).setValue(newTitle)
    }
    
    func updateNumberOfComment(threadId: String, count: Int) {
        ref.child("discuss").child("threads").child(threadId).child("numberOfComment").setValue(count)
    }
    
    /**
     Get all thread
     - max: max of number thread which user can see
     - Get all thread
     **/
    func getThread(max: NSInteger, onCompletionHandler: @escaping ([ThreadModel]) -> ()) {
        self.ref.child("discuss").child("threads").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
            var threadArray = [ThreadModel]()
            for dict in snapDict as! [String: [String: AnyObject]]{
                let thread = ThreadModel()
                
                let title       = dict.value["title"] != nil ? dict.value["title"] as! String : ""
                let content     = dict.value["content"] != nil ? dict.value["content"] as! String : ""
                let userName    = dict.value["userName"] != nil ? dict.value["userName"] as! String : "Ẩn danh"
                let time        = dict.value["time"] as! Double
                let lastComment = dict.value["lastComment"] as! Double
                let favorite    = dict.value["favorite"] != nil ? dict.value["favorite"] as! String : ""
                let number      = dict.value["numberOfComment"] != nil ? dict.value["numberOfComment"] as! Int : 0

                thread.initThread(id: dict.key, title: title, content: content, time: time, userName: app_delegate.userDictionary[userName]!, userId: userName, lastComment: lastComment, favorite: favorite, numberOfComment: number)
                if threadArray.count > 0 {
                    threadArray.insert(thread, at: 0)
                } else {
                    threadArray.append(thread)
                }
            }
            onCompletionHandler(threadArray.sorted(by: {$0.lastComment > $1.lastComment}))
        })
    }
    
    /**
     Get favorite chat
     - max: max of number thread which user can see
     - Get favorite thread
     **/
    func getFavoriteThread(max: NSInteger, onCompletionHandler: @escaping ([ThreadModel]) -> ()) {
        self.ref.child("discuss").child("threads").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
            var threadArray = [ThreadModel]()
            for dict in snapDict as! [String: [String: AnyObject]]{
                let thread = ThreadModel()
                
                let title       = dict.value["title"] != nil ? dict.value["title"] as! String : ""
                let content     = dict.value["content"] != nil ? dict.value["content"] as! String : ""
                let userName    = dict.value["userName"] != nil ? dict.value["userName"] as! String : "Ẩn danh"
                let time        = dict.value["time"] as! Double
                let lastComment = dict.value["lastComment"] as! Double
                let favorite    = dict.value["favorite"] != nil ? dict.value["favorite"] as! String : ""
                let number      = dict.value["numberOfComment"] != nil ? dict.value["numberOfComment"] as! Int : 0

                if favorite.contains((UIDevice.current.identifierForVendor?.uuidString)!) {
                    thread.initThread(id: dict.key, title: title, content: content, time: time, userName: app_delegate.userDictionary[userName]!, userId: userName, lastComment: lastComment, favorite: favorite, numberOfComment: number)
                    if threadArray.count > 0 {
                        threadArray.insert(thread, at: 0)
                    } else {
                        threadArray.append(thread)
                    }
                }
            }
            onCompletionHandler(threadArray.sorted(by: {$0.lastComment > $1.lastComment}))
        })
    }
    
    /**
     - max: max of number thread which user can see
     - Get my thread
     **/
    func getMyThread(max: NSInteger, onCompletionHandler: @escaping ([ThreadModel]) -> ()) {
        self.ref.child("discuss").child("threads").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
            var threadArray = [ThreadModel]()
            for dict in snapDict as! [String: [String: AnyObject]]{
                let thread = ThreadModel()
                
                let title       = dict.value["title"] != nil ? dict.value["title"] as! String : ""
                let content     = dict.value["content"] != nil ? dict.value["content"] as! String : ""
                let userName    = dict.value["userName"] != nil ? dict.value["userName"] as! String : "Ẩn danh"
                let time        = dict.value["time"] as! Double
                let lastComment = dict.value["lastComment"] as! Double
                let favorite    = dict.value["favorite"] != nil ? dict.value["favorite"] as! String : ""
                let number      = dict.value["numberOfComment"] != nil ? dict.value["numberOfComment"] as! Int : 0

                if userName == (UIDevice.current.identifierForVendor?.uuidString)! {
                    thread.initThread(id: dict.key, title: title, content: content, time: time, userName: app_delegate.userDictionary[userName]!, userId: userName, lastComment: lastComment, favorite: favorite, numberOfComment: number)
                    if threadArray.count > 0 {
                        threadArray.insert(thread, at: 0)
                    } else {
                        threadArray.append(thread)
                    }
                }
            }
            onCompletionHandler(threadArray.sorted(by: {$0.lastComment > $1.lastComment}))
        })
    }
    
    /**
     - max: max of number thread which user can see
     - Get threads in this week
     **/
    func getWeekThread(max: NSInteger, onCompletionHandler: @escaping ([ThreadModel]) -> ()) {
        self.ref.child("discuss").child("threads").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
            
            let serverTimestamp = ServerValue.timestamp()
            self.ref.child("currentTime").setValue(serverTimestamp)
            
            self.ref.child("currentTime").observeSingleEvent(of: .value, with: { (snapshot) in
                var threadArray = [ThreadModel]()
                for dict in snapDict as! [String: [String: AnyObject]]{
                    let thread = ThreadModel()
                    
                    let title       = dict.value["title"] != nil ? dict.value["title"] as! String : ""
                    let content     = dict.value["content"] != nil ? dict.value["content"] as! String : ""
                    let userName    = dict.value["userName"] != nil ? dict.value["userName"] as! String : "Ẩn danh"
                    let time        = dict.value["time"] as! Double
                    let lastComment = dict.value["lastComment"] as! Double
                    let favorite    = dict.value["favorite"] != nil ? dict.value["favorite"] as! String : ""
                    let number      = dict.value["numberOfComment"] != nil ? dict.value["numberOfComment"] as! Int : 0

                    let serverTimestamp = snapshot.value as! Double
                    let days = Int(serverTimestamp/86400000)
                    let newTime: Double = Double(days) * 86400000.0
                    
                    let dayOfWeek = Date().getDayOfWeek()
                    let startweekTime = newTime - Double((dayOfWeek - 2) * 86400000)
                    
                    if time >= Double(startweekTime) {
                        thread.initThread(id: dict.key, title: title, content: content, time: time, userName: app_delegate.userDictionary[userName]!, userId: userName, lastComment: lastComment, favorite: favorite, numberOfComment: number)
                        if threadArray.count > 0 {
                            threadArray.insert(thread, at: 0)
                        } else {
                            threadArray.append(thread)
                        }
                    }
                }
                onCompletionHandler(threadArray.sorted(by: {$0.lastComment > $1.lastComment}))
            })
        })
    }
    
    /**
     - max: max of number thread which user can see
     - Get hot threads
     **/
    func gethotThread(max: NSInteger, onCompletionHandler: @escaping ([ThreadModel]) -> ()) {
        self.ref.child("discuss").child("threads").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
            
            let serverTimestamp = ServerValue.timestamp()
            self.ref.child("currentTime").setValue(serverTimestamp)
            
            self.ref.child("currentTime").observeSingleEvent(of: .value, with: { (snapshot) in
                var threadArray = [ThreadModel]()
                for dict in snapDict as! [String: [String: AnyObject]]{
                    let thread = ThreadModel()
                    
                    let title       = dict.value["title"] != nil ? dict.value["title"] as! String : ""
                    let content     = dict.value["content"] != nil ? dict.value["content"] as! String : ""
                    let userName    = dict.value["userName"] != nil ? dict.value["userName"] as! String : "Ẩn danh"
                    let time        = dict.value["time"] as! Double
                    let lastComment = dict.value["lastComment"] as! Double
                    let favorite    = dict.value["favorite"] != nil ? dict.value["favorite"] as! String : ""
                    let number      = dict.value["numberOfComment"] != nil ? dict.value["numberOfComment"] as! Int : 0
                    
                    thread.initThread(id: dict.key, title: title, content: content, time: time, userName: app_delegate.userDictionary[userName]!, userId: userName, lastComment: lastComment, favorite: favorite, numberOfComment: number)
                    if threadArray.count > 0 {
                        threadArray.insert(thread, at: 0)
                    } else {
                        threadArray.append(thread)
                    }
                }
                threadArray = threadArray.sorted(by: {$0.numberOfComment > $1.numberOfComment})
                var newThreadArray = [ThreadModel]()
                for newThread in threadArray {
                    if newThreadArray.count < 10 {
                        newThreadArray.append(newThread)
                    } else {
                        break
                    }
                }
                onCompletionHandler(newThreadArray.sorted(by: {$0.numberOfComment > $1.numberOfComment}))
            })
        })
    }
    
    /**
     - threadId: id of thread
     - favorite: All user favorite this thread
     **/
    func favoriteThread(threadId: String, favorite: String) {
        self.ref.child("discuss").child("threads").child(threadId).child("favorite").setValue(favorite)
    }
    
    //MARK: - COMMENTS
    
    func createNewComment(threadId: String, comment: String, onCompletionHandler: @escaping () -> ()) {
        //comform to contact id
        let serverTimestamp = ServerValue.timestamp()
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("discuss").child("comment").child(threadId)
        //comform to waiting share property

        let commentDict = ["userName": (UIDevice.current.identifierForVendor?.uuidString)!, "content":comment, "time":serverTimestamp, "like": ""] as [String : Any]
        resultRef.childByAutoId().setValue(commentDict)
        
        //update last comment time
        ref.child("discuss").child("threads").child(threadId).child("lastComment").setValue(serverTimestamp)
        onCompletionHandler()
    }
    
    func deleteComment(threadId: String, commentId: String, onCompletionHandler: @escaping () -> ()) {
        ref.child("discuss").child("comment").child(threadId).child(commentId).removeValue()
    }
    
    func editComment(threadId: String, commentId:String, newComment: String) {
        ref.child("discuss").child("comment").child(threadId).child(commentId).setValue(newComment)
    }
    
    func getFirstComment(threadId: String, onCompletionHandler: @escaping ([CommentModel]) -> ()) {
        self.ref.child("discuss").child("comment").child(threadId).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
            var commentArray = [CommentModel]()
            for dict in snapDict as! [String: [String: AnyObject]]{
                let comment = CommentModel()
                let detail: [String: AnyObject] = dict.value
                
                let content     = detail["content"] != nil ? detail["content"] as! String : ""
                let userName    = detail["userName"] != nil ? detail["userName"] as! String : ""
                let time        = detail["time"] as! Double
                let like        = detail["like"] as! String
                
                comment.initComment(threadId: dict.key, id: dict.key, content: content, userName: app_delegate.userDictionary[userName]!, time: time, like: like)
                commentArray.append(comment)
            }

            DispatchQueue.global().async {
                app_delegate.firebaseObject.updateNumberOfComment(threadId: threadId, count: commentArray.count)
            }
            onCompletionHandler(commentArray.sorted(by: {$0.id < $1.id}))
        })
    }
    
    func getComment(threadId: String, onCompletionHandler: @escaping ([CommentModel]) -> ()) {
        self.ref.child("discuss").child("comment").child(threadId).queryOrderedByKey().observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
            var commentArray = [CommentModel]()
            for dict in snapDict as! [String: [String: AnyObject]]{
                let comment = CommentModel()
                let detail: [String: AnyObject] = dict.value
                
                let content     = detail["content"] != nil ? detail["content"] as! String : ""
                let userName    = detail["userName"] != nil ? detail["userName"] as! String : ""
                let time        = detail["time"] as! Double
                let like        = detail["like"] as! String
                
                comment.initComment(threadId: dict.key, id: dict.key, content: content, userName: app_delegate.userDictionary[userName]!, time: time, like: like)
                commentArray.append(comment)
            }
            
            onCompletionHandler(commentArray.sorted(by: {$0.id < $1.id}))
        })
    }
    
    func editCommentLike(threadId: String, commentId:String, newLike: String) {
        ref.child("discuss").child("comment").child(threadId).child(commentId).child("like").setValue(newLike)
    }
    
    //MARK: - DOCTOR COMMENTS
    
    func getDoctorComment(doctorId: String, onCompletionHandler: @escaping ([CommentModel]) -> ()) {
        self.ref.child("doctor").child(doctorId).queryOrderedByKey().observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
            var commentArray = [CommentModel]()
            for dict in snapDict as! [String: [String: AnyObject]]{
                let comment = CommentModel()
                let detail: [String: AnyObject] = dict.value
                
                let content     = detail["content"] != nil ? detail["content"] as! String : ""
                let userName    = detail["userName"] != nil ? detail["userName"] as! String : ""
                let time        = detail["time"] as! Double
                let like        = detail["like"] as! String
                
                comment.initComment(threadId: dict.key, id: dict.key, content: content, userName: app_delegate.userDictionary[userName]!, time: time, like: like)
                commentArray.append(comment)
            }
            
            onCompletionHandler(commentArray.sorted(by: {$0.id < $1.id}))
        })
    }
    
    func createDoctorComment(doctorId: String, comment: String, onCompletionHandler: @escaping () -> ()) {
        //comform to contact id
        let serverTimestamp = ServerValue.timestamp()
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("doctor").child(doctorId)
        //comform to waiting share property
        let commentDict = ["userName": (UIDevice.current.identifierForVendor?.uuidString)!, "content":comment, "time":serverTimestamp, "like": ""] as [String : Any]
        resultRef.childByAutoId().setValue(commentDict)
        onCompletionHandler()
    }
    
    func getDoctorList(onCompletionHandler: @escaping ([DoctorModel]) -> ()) {
        ref.child("doctor_list").queryOrdered(byChild: "star").observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String: [String : AnyObject]] ?? [:]
            var doctorArray = [DoctorModel]()
            for doctorDict in snapDict {
                let doctor = DoctorModel()
                
                doctor.initDoctorModel(doctor: doctorDict.value)
                doctorArray.append(doctor)
            }
            
            onCompletionHandler(doctorArray.sorted(by: {$0.starPoint > $1.starPoint}))
        })
    }
    
    func editDoctorCommentLike(doctorId: String, commentId:String, newLike: String) {
        ref.child("doctor").child(doctorId).child(commentId).child("like").setValue(newLike)
    }
    
    func rankDoctor(doctorId: String, star: String,rank: String, onCompletionHandler: @escaping () -> ()) {
        //comform to contact id
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("doctor_list").child(doctorId)
        //comform to waiting share property
        resultRef.child("star").setValue(star)
        resultRef.child("rank").setValue(rank)
        onCompletionHandler()
    }
}
