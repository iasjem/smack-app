//
//  AddChannelVC.swift
//  smack-app
//
//  Created by Jemimah Beryl M. Sai on 24/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    @IBOutlet weak var channelNameText: UITextField!
    @IBOutlet weak var channelDescriptionText: UITextField!
    @IBOutlet weak var bgView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func createChannelButtonPressed(_ sender: Any) {
        guard let channelName = channelNameText.text, channelNameText.text != "" else {  return  }
        guard let channelDescription = channelDescriptionText.text else {  return  }
        SocketService.instance.addChannel(name: channelName, description: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        channelNameText.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        channelDescriptionText.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.bgView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        dismiss(animated: true, completion: nil)
    }

}
