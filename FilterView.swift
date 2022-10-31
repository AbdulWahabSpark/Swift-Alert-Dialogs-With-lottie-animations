//
//  FilterView.swift
//  My Trane Rewards
//
//  Created by Pixiders on 04/03/2020.
//  Copyright © 2020 Pixiders. All rights reserved.
//

import UIKit
import rubber_range_picker

class FilterView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var pickerRange: RubberRangePicker!
    @IBOutlet weak var lblMinimum: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var tfSearch: UITextFieldX!
    @IBOutlet weak var innerView: UIViewX!
    
    //MARK:- Action
    @IBAction func tapped(_ sender: Any) {
        dismiss()
    }
    @IBAction func search(_ sender: Any) {
        if let searchResult = self.searchResult {
            searchResult(tfSearch.text!,minimumPoint,maximumPoint)
        }
    }
    @IBAction func valueChanges(_ sender: Any) {
        setRangeValue()
    }
    
    //MARK:- Veriables
    var minimumPoint = "0"
    var maximumPoint = "10000"
    var searchResult: ((_ q:String,_ min:String,_ max:String)->Void)? = nil
    
    class func instanceFromNib() -> FilterView {
        return UINib(nibName: Nibs.FilterView.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FilterView
    }
    func present(size:CGRect){
        self.frame = size
        let top = CGAffineTransform(translationX: 0, y: -30)
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
            self.innerView.transform = top
        })
    }
    func dismiss(){
        let bottom = CGAffineTransform(translationX: 0, y: 50)
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
            self.innerView.transform = bottom
        })
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
            self.removeFromSuperview()
        })
    }
    
    func setRangeValue(){
        minimumPoint = String(pickerRange.lowerValue.rounded()).replacingOccurrences(of: ".0", with: "")
        maximumPoint = String(pickerRange.upperValue.rounded()).replacingOccurrences(of: ".0", with: "")
        
        lblMinimum.text = minimumPoint
        lblMax.text = maximumPoint
    }
}
