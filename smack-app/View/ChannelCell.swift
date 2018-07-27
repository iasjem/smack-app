//
//  ChannelCell.swift
//  smack-app
//
//  Created by Jemimah Beryl M. Sai on 24/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var channelNameLabel: UILabel!

    // MARK: Overrides
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = #colorLiteral(red: 0.3156195879, green: 0.3156195879, blue: 0.3156195879, alpha: 0.25)
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    // MARK: Helpers

    func configureCell(channel: Channel) {
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
        channelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
    }
}
