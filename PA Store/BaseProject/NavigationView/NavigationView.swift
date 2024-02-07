//
//  NavigationView.swift
//  medIQTemp
//
//  Created by Muhammad Ameen on 03/08/2022.
//

import UIKit

class NavigationView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var lblCounter: UILabel!
    
    var delegate: NavigationViewProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    @IBAction func tapOnSideMenu(_ sender: Any) {
        delegate.didTapOnSideMenu?()
    }
    
    @IBAction func tapOnMessages(_ sender: Any) {
        delegate.didTapOnMessage?()
    }
    
    @IBAction func tapOnProfile(_ sender: UIButton) {
        delegate.didTapOnRightBtn2?()
    }
}
