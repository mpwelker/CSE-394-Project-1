//
//  ParseChanges.swift
//  CSE 394 Project 1
//
//  Created by Dana Johnson on 4/6/15.
//  Copyright (c) 2015 Michael Welker. All rights reserved.
//

import Foundation

class ParseChanges {
    
    class var sharedInstance: ParseChanges {
        struct Static {
            static let instance = ParseChanges()
        }
        return Static.instance
    }
    
    var favoritesDidChange: Bool = true
    var galleryDidChange: Bool = true
    var artistsDidChange: Bool = true
    
}