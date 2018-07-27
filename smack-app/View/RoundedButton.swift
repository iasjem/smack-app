//
//  RoundedButton.swift
//  smack-app
//
//  Created by Jemimah Beryl M. Sai on 23/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    // MARK: @IBInspectables
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    // MARK: Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    // MARK: Helpers
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
}
