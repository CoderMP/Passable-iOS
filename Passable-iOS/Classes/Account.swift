//
//  Account.swift
//  Passable-iOS
//
//  Created by Mark Philips on 9/25/18.
//  Copyright © 2018 Mark Philips. All rights reserved.
//

import UIKit

class Account: NSObject {
    var savedUserName : String?
    var savedSocialMediaName : String?
    var savedPassword : String?
    var savedGlyph : String?
    
    /*
     * Constructor function for the Account class
     */
    func initWithData(socialMedia : String, username : String, userPass : String, glyph: String) {
        savedSocialMediaName = socialMedia
        savedUserName = username
        savedPassword = userPass
        savedGlyph = glyph
    }
}
