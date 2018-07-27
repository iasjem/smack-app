//
//  Helpers.swift
//  smack-app
//
//  Created by Jemimah Beryl M. Sai on 27/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
