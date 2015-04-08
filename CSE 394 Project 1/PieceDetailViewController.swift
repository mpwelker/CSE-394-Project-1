//
//  GalleryDetailViewController.swift
//  CSE 394 Project 1
//
//  Created by Dana Johnson on 4/3/15.
//  Copyright (c) 2015 Michael Welker. All rights reserved.
//

import UIKit
import Parse

class PieceDetailViewController: UIViewController {
    
    var piece: PFObject!
    var fav: Bool = false
    
    @IBOutlet weak var image_ImageView: UIImageView!
    @IBOutlet weak var artist_Label: UILabel!
    @IBOutlet weak var date_Label: UILabel!
    @IBOutlet weak var exhibit_Label: UILabel!
    @IBOutlet weak var location_Label: UILabel!
    @IBOutlet weak var medium_Label: UILabel!
    @IBOutlet weak var notes_textView: UITextView!
    @IBOutlet weak var year_Label: UILabel!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TITLE
        if let title = piece.objectForKey("title") as? NSString {
            self.navigationItem.title = title
        } else {
            self.navigationItem.title = "--"
        }
        
        // ARTIST
        if let artist = piece.objectForKey("artist") as? NSString {
            self.artist_Label.text = artist
        } else {
            self.artist_Label.text = "--"
        }
        
        // FAVORITE
        if let favorite = piece.objectForKey("favorite") as? Bool {
            self.fav = favorite
            if self.fav {
                self.favoriteButton.image = UIImage(named: "thumb_up_active")
            } else {
                self.favoriteButton.image = UIImage(named: "thumb_up_inactive")
            }
        } else {
            self.favoriteButton.image = UIImage(named: "thumb_up_inactive")
        }
        
        // DATE
        if let date = piece.objectForKey("date") as? NSDate {
            self.date_Label.text = "\(date)"
        } else {
            self.date_Label.text = "--"
        }
        
        // EXHIBIT
        if let exhibit = piece.objectForKey("exhibit") as? NSString {
            self.exhibit_Label.text = exhibit
        } else {
            self.exhibit_Label.text = "--"
        }
        
        // IMAGE
        if let imageFile = piece.objectForKey("image") as? PFFile {
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
            spinner.frame = CGRectMake(0.0, 0.0, 40, 40)
            spinner.center = self.view.center
            let spinnerBG = UIView(frame: self.view.frame)
            spinnerBG.center = self.view.center
            spinnerBG.backgroundColor = UIColor.blackColor()
            spinnerBG.alpha = 0.7
            spinnerBG.addSubview(spinner)
            self.view.addSubview(spinnerBG)
            spinner.startAnimating()
            self.navigationItem.rightBarButtonItem?.enabled = false
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                let imageData = imageFile.getData()
                dispatch_async(dispatch_get_main_queue(), {
                    self.navigationItem.rightBarButtonItem?.enabled = true
                    spinner.stopAnimating()
                    spinnerBG.removeFromSuperview()
                    if let image = UIImage(data: imageData) {
                        self.image_ImageView.image = image
                    } else {
                        self.image_ImageView.image = UIImage(named: "No_Image_Available")
                    }
                })
            })
        } else {
            self.image_ImageView.image = UIImage(named: "No_Image_Available")
        }
        
        // LOCATION
        if let location = piece.objectForKey("location") as? NSString {
            self.location_Label.text = location
        } else {
            self.location_Label.text = "--"
        }
        
        // MEDIUM
        if let medium = piece.objectForKey("medium") as? NSString {
            self.medium_Label.text = medium
        } else {
            self.medium_Label.text = "--"
        }
        
        // NOTES
        if let notes = piece.objectForKey("notes") as? NSString {
            self.notes_textView.text = notes
        } else {
            self.notes_textView.text = "None"
        }
        self.notes_textView.scrollRangeToVisible(NSRange(location: 0, length: 0))
        
        // YEAR
        if let year = piece.objectForKey("year") as? Int {
            self.year_Label.text = "\(year)"
        } else {
            self.year_Label.text = "--"
        }
    }

    @IBAction func favoriteThis(sender: AnyObject) {
        self.fav = !self.fav
        if self.fav {
            self.favoriteButton.image = UIImage(named: "thumb_up_active")
        } else {
            self.favoriteButton.image = UIImage(named: "thumb_up_inactive")
        }
        self.piece["favorite"] = self.fav
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            if self.piece.save() {
                ParseChanges.sharedInstance.favoritesDidChange = true
            }
            return
        })
    }
}
