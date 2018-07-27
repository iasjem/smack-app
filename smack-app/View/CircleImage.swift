//
//  CircleImage.swift
//  smack-app
//
//  Created by Jemimah Beryl M. Sai on 24/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    // MARK: Overrides
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    // MARK: Helpers
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
