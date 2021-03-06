//
//  AddChannelVC.swift
//  smack-app
//
//  Created by Jemimah Beryl M. Sai on 24/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var channelNameText: UITextField!
    @IBOutlet weak var channelDescriptionText: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    // MARK: View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGestures()
    }
    
    // MARK: IBActions
    
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
    
    // MARK: Setups
    
    func setupView() {
        channelNameText.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDER_COLOR])
        channelDescriptionText.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDER_COLOR])
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.bgView.addGestureRecognizer(tap)
    }
    
    // MARK: Helpers
    
    @objc func handleTap() {
        dismiss(animated: true, completion: nil)
    }
}
