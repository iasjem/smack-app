//
//  ChannelVC.swift
//  smack-app
//
//  Created by Jemimah Beryl M. Sai on 20/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addChannelButton: UIButton!
    @IBOutlet weak var channelsTitleLabel: UILabel!
    
    // MARK: View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupView()
        setupNotificationCenters()
        setupFromSocketService()
    }
    
    // MARK: IBActions
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) { }
    
    @IBAction func addChannelButtonPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender : Any) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    // MARK: Setups
    
    func setupView() {
        addChannelButton.isHidden = true
        channelsTitleLabel.isHidden = true
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60
    }

    func setupNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelsLoaded), name: NOTIF_CHANNELS_LOADED, object: nil)
    }
    
    func setupFromSocketService() {
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tableView.reloadData()
            }
        }
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            addChannelButton.isHidden = false
            channelsTitleLabel.isHidden = false
            loginButton.setTitle("\(UserDataService.instance.name)", for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            addChannelButton.isHidden = true
            channelsTitleLabel.isHidden = true
            loginButton.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
            tableView.reloadData()
        }
    }
    
    // MARK: Helpers
    
    @objc func userDataDidChange(_ notif: Notification) {
        setupUserInfo()
    }

    @objc func channelsLoaded(_ notif: Notification) {
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate

extension ChannelVC: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.id}
        }
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.reloadRows(at: [index], with: .none)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
    }
}

// MARK: UITableViewDataSource

extension ChannelVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell else {
             return UITableViewCell()
        }
        let channel = MessageService.instance.channels[indexPath.row]
        cell.configureCell(channel: channel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
}
