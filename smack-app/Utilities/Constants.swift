//
//  Constants.swift
//  smack-app
//
//  Created by Jemimah Beryl M. Sai on 23/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let BASE_URL = "https://smack-chat-clone.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
