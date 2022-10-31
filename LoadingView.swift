//
//  LoadingView.swift
//  My Trane Rewards
//
//  Created by Pixiders on 18/02/2020.
//  Copyright © 2020 Pixiders. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {
    
    @IBOutlet weak var loadingAnimationView: AnimationView!
    
    class func instanceFromNib() -> LoadingView {
        return UINib(nibName: Nibs.LoadingView.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingView
    }
    func present(size:CGRect){
        self.frame = size
        self.loadingAnimation()
    }
    private func loadingAnimation(){
        let anim = Animation.named("loading_white.json")
        self.loadingAnimationView.animation = anim
        self.loadingAnimationView.play()
        self.loadingAnimationView.loopMode = .loop
    }
    func dismiss(){
        self.loadingAnimationView.stop()
        self.removeFromSuperview()
    }
}
