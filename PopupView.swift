//
//  PopupView.swift
//  My Trane Rewards
//
//  Created by Pixiders on 09/03/2020.
//  Copyright © 2020 Pixiders. All rights reserved.
//

import UIKit

class PopupView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnDescription: UIButton!
    @IBOutlet weak var circularView: UIViewCircular!
    
    //MARK:- Actions
    @IBAction func buttonAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    //MARK:- Veriables
    let progressShape = CAShapeLayer()
    let backgroundShape = CAShapeLayer()
    let percent = 0.0
    var popup:Popup!
    
    class func instanceFromNib() -> PopupView {
        
        return UINib(nibName: Nibs.PopupView.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PopupView
    }
    
    func show(popup:Popup,size:CGRect){
        self.layer.addSublayer(backgroundShape)
        self.layer.addSublayer(progressShape)
        self.popup = popup
        self.frame = size
        let loader = ImageLoader(image: imageView, link: popup.Image)
        loader.load()
        lblTitle.text = popup.Title
        lblDescription.text = popup.Description
        btnDescription.setTitle(popup.Button, for: .normal)
        updateIndicator(with: percent, isAnimated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + popup.Duration, execute: {
             self.removeFromSuperview()
        })
    }
    
    func updateIndicator(with percent: Double, isAnimated: Bool = false) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = progressShape.strokeEnd
        animation.toValue = percent / 100.0
        animation.duration = popup.Duration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut);
        
        let shortestSide = min(circularView.frame.size.width, circularView.frame.size.height) - 30
        let strokeWidth: CGFloat = 10.0
        let frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        
        backgroundShape.frame = frame
        backgroundShape.position = circularView.center
        backgroundShape.path = UIBezierPath(ovalIn: frame).cgPath
        backgroundShape.strokeColor = UIColor.clear.cgColor
        backgroundShape.lineWidth = strokeWidth
        backgroundShape.fillColor = UIColor.clear.cgColor
        
        progressShape.frame = frame
        progressShape.path = backgroundShape.path
        progressShape.position = backgroundShape.position
        progressShape.strokeColor = UIColor.white.cgColor
        progressShape.lineWidth = backgroundShape.lineWidth
        progressShape.fillColor = UIColor.clear.cgColor
        progressShape.strokeEnd = CGFloat(percent/100.0)
        
        if isAnimated {
          progressShape.add(animation, forKey: nil)
        }
      }
}
