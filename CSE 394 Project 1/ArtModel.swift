//
//  ArtModel.swift
//  CSE 394 Project 1
//
//  Created by Michael Welker on 2/26/15.
//  Copyright (c) 2015 Michael Welker. All rights reserved.
//

import UIKit

class ArtModel : NSObject {

    var title : NSString
    var artist : NSString
    var year : Int
    var photo : UIImage // unused here, implemented in Pt. 2
    // More data is stored for pieces than is present here, including
    // date, location, exhibition, medium, notes, and favorite status
    
    override init() {
        self.title = NSString()
        self.artist = NSString()
        self.year = Int()
        self.photo = UIImage()
    }
    
}
