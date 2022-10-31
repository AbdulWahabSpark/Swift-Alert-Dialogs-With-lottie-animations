//
//  OnBoard.swift
//  My Trane Rewards
//
//  Created by Pixiders on 25/02/2020.
//  Copyright © 2020 Pixiders. All rights reserved.
//

import UIKit
import Lottie

class OnBoard: UIView {
    
    @IBOutlet weak var plusView: UIViewCircular!
    @IBOutlet weak var plusY: NSLayoutConstraint!
    @IBOutlet weak var plusX: NSLayoutConstraint!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var plusViewHeight: NSLayoutConstraint!
    @IBOutlet weak var plusViewWidth: NSLayoutConstraint!
    @IBOutlet weak var animationTop: NSLayoutConstraint!
    @IBOutlet weak var animationCenter: NSLayoutConstraint!
    @IBOutlet weak var btnClose: UIButtonX!
    
    var state = 0
    
    @IBAction func close(_ sender: Any) {
        state += 1
        if state == 1{
            animationView.stop()
            showCart()
        } else if state == 2 {
            btnClose.setTitle("Close", for: .normal)
            showWishlist()
        } else {
            UserDefaults.standard.set(true, forKey: OnBoardKey)
            Global.shared.isOnBoard = false
            self.removeFromSuperview()
        }
    }
    
    class func instanceFromNib() -> OnBoard {
        return UINib(nibName: Nibs.OnBoard.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! OnBoard
    }
    func show(frame:CGRect,fullFrame:CGRect){
        
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top
        
        plusY.constant = fullFrame.minY + frame.maxY + (topPadding ?? 0) - 5
        plusX.constant = fullFrame.minX + frame.maxX - plusView.frame.width - 5
        
        let anim = Animation.named("tap")
        animationView.animation = anim
        animationView.play()
        animationView.loopMode = .loop
    }
    func showCart(){
        lblText.text = "Drag towards Wishlist \nFor Add To Wishlist"
        UIView.animate(withDuration: 0.5, animations: {
            self.plusViewHeight.constant = 40
            self.plusViewWidth.constant = 40
            self.plusView.layer.cornerRadius = 20
            self.layoutIfNeeded()
        },completion: { _ in
            let anim = Animation.named("gestuar")
            self.animationTop.constant = self.animationTop.constant + 20
            self.animationCenter.constant = self.animationCenter.constant
            self.animationView.animation = anim
            self.animationView.play()
            self.animationView.rotate(angle: 45)
            self.animationView.loopMode = .loop
        })
    }
    func showWishlist(){
        lblText.text = "Drag towards Cart \nFor Add To Cart"
        self.animationCenter.constant = self.animationCenter.constant + 50
        animationView.rotate(angle: -50)
    }
    
}
