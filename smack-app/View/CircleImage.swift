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

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
}
