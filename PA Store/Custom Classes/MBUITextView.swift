//
//  MBUITextView.swift
//  HomeMedics Labour
//
//  Created byDevBatch on 22/08/2017.
//  Copyright © 2017DevBatch. All rights reserved.
//

import Foundation
import UIKit

@objc protocol MBUITextViewDelegate: NSObjectProtocol {
    func textviewDidEndEditing()
}


@IBDesignable public class MBUITextView: UITextView, UITextViewDelegate {

    public var placeHolder: String = ""
    weak var mbDelegate: MBUITextViewDelegate?
    
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.delegate = self
    }

//    @IBInspectable
//    public var placeholderTextt: String = "" {
//        didSet {
//            self.placeHolder = placeholderTextt
//            self.setupPlaceHolder()
//            self.setNeedsLayout()
//        }
//    }

    func setupPlaceHolder(_ text: String) {
        self.text = text
        self.placeHolder = text
        self.textColor = UIColor.emailTextFiledPlaceHolderTextColor()
    }
    
    
    func setText(_ text: String) {
        if !text.isEmpty && text != self.placeHolder {
            self.text = text
            self.textColor = UIColor.black
        }
    }
    
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHolder {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }

    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            setupPlaceHolder(placeHolder)
        }
        
        mbDelegate?.textviewDidEndEditing()
    }
}
