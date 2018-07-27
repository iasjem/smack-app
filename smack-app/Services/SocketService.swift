//
//  SocketService.swift
//  smack-app
//
//  Created by Jemimah Beryl M. Sai on 25/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    // MARK: Initializers
    
    static let instance = SocketService()
    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    
    override init() {
        super.init()
    }
    
    // MARK: Getters
    
    func getChannel(completion: @escaping CompletionHandler) {
        manager.defaultSocket.on(SOCKET_EVENT_CHANNEL_CREATED) { (dataArray, ack) in
            guard let name = dataArray[0] as? String else { return }
            guard let description = dataArray[1] as? String else { return }
            guard let id = dataArray[2] as? String else { return }
            let newChannel = Channel(channelTitle: name, channelDescription: description, id: id)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func getChatMessage(completion: @escaping (_ newMessage: Message) -> Void) {
        manager.defaultSocket.on(SOCKET_EVENT_MESSAGE_CREATED) { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else {  return  }
            guard let channelId = dataArray[2] as? String else {  return  }
            guard let userName = dataArray[3] as? String else {  return  }
            guard let userAvatar = dataArray[4] as? String else {  return  }
            guard let userAvatarColor = dataArray[5] as? String else {  return  }
            guard let id = dataArray[6] as? String else {  return  }
            guard let timeStamp = dataArray[7] as? String else {  return  }
            let newMessage = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            completion(newMessage)
        }
    }
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        manager.defaultSocket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else {  return  }
            completionHandler(typingUsers)
        }
    }
    
    // MARK: Helpers
    
    func establishConnection() {
        manager.defaultSocket.connect()
    }
    
    func closeConnection() {
        manager.defaultSocket.disconnect()
    }
    
    func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
        manager.defaultSocket.emit(SOCKET_EVENT_NEW_CHANNEL, name, description)
        completion(true)
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        manager.defaultSocket.emit(SOCKET_EVENT_NEW_MESSAGE, messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
}
