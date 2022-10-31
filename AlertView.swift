//
//  AlterView.swift
//  My Trane Rewards
//
//  Created by Pixiders on 18/02/2020.
//  Copyright © 2020 Pixiders. All rights reserved.
//

import UIKit
import Lottie

class AlertView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var loginBGView: UIView!
    @IBOutlet weak var loadingAnimationView: AnimationView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnYes: UIButtonX!
    @IBOutlet weak var btnOk: UIButtonX!
    
    @IBOutlet weak var loginBtn: UIButtonX!
    @IBOutlet weak var loadingAnimationView1: AnimationView!
    //MARK:- Actions
    @IBAction func dismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func performActions(_ sender: Any) {
        if let completation = completation{
            completation(true)
        }
    }
    @IBAction func performActions1(_ sender: Any) {
        if let completation = completation {
            completation(true)
            self.dismiss1()
        }
    }
    var completation:((Bool)->Void)? = nil
    
    class func instanceFromNib() -> AlertView {
        return UINib(nibName: "Alert", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AlertView
    }
    class func instanceFromNib2() -> AlertView {
        return UINib(nibName: "LoginAlert", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AlertView
    }
    @IBAction func clearBtnAction(_ sender: Any) {
        dismiss1()
    }
    func present(size:CGRect,type:AlertType,message:String) {
        self.frame = size
        if let lblmessage = lblMessage {
            lblMessage.text = message
        }
        switch type {
        case .Success:
            success()
        case .Failed:
            failure()
        case .Sure:
            sure()
        case .Login:
            login_alert()
        }
    }
    private func success() {
        lblTitle.text = "Success"
        btnOk.setTitle("OK", for: .normal)
        btnYes.alpha = 0
        let anim = Animation.named("success1.json")
        self.loadingAnimationView.animation = anim
        self.loadingAnimationView.play()
        self.loadingAnimationView.loopMode = .playOnce
    }
    private func failure() {
        lblTitle.text = "Failure"
        btnOk.setTitle("OK", for: .normal)
        btnYes.alpha = 0
        let anim = Animation.named("error1.json")
        self.loadingAnimationView.animation = anim
        self.loadingAnimationView.play()
        self.loadingAnimationView.loopMode = .loop
    }
    private func sure() {
        lblTitle.text = "Are You Sure?"
        btnOk.setTitle("No", for: .normal)
        btnYes.alpha = 1
        let anim = Animation.named("sure1.json")
        self.loadingAnimationView.animation = anim
        self.loadingAnimationView.play()
        self.loadingAnimationView.loopMode = .loop
    }
    private func login_alert() {
        //lblTitle.text = "Kindly login yourself!"
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.alpha = 1
        let anim = Animation.named("error1.json")
        self.loadingAnimationView1.animation = anim
        self.loadingAnimationView1.play()
        self.loadingAnimationView1.loopMode = .loop
    }
    func dismiss() {
        self.loadingAnimationView.stop()
        self.removeFromSuperview()
    }
    func dismiss1() {
        self.loadingAnimationView1.stop()
        self.removeFromSuperview()
    }
}
enum AlertType {
    case Success
    case Failed
    case Sure
    case Login
}
