//
//  AddPieceViewController.swift
//  CSE 394 Project 1
//
//  Created by Michael Welker on 2/26/15.
//  Copyright (c) 2015 Michael Welker. All rights reserved.
//

import UIKit
import Parse

class AddPieceViewController : UIViewController {
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtArtist: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnSubmit.enabled = false
        checkComplete()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Enable submission button only if both ARTIST and TITLE field contain text
    func checkComplete() -> Bool {
        if (txtTitle.text.isEmpty || txtArtist.text.isEmpty) {
            btnSubmit.enabled = false
            return false
        }
        btnSubmit.enabled = true
        return true
    }
    
    // Submit piece to database (if TITLE/ARTIST requirements met)
    @IBAction func btnSubmit(sender: AnyObject) {
        if (checkComplete()) {
            let art = ArtModel()
            art.title = txtTitle.text
            art.artist = txtArtist.text
            if (!txtYear.text.isEmpty) {
                art.year = txtYear.text.toInt()!
            }
            
            let obj = PFObject(className: "Artwork")
            obj["title"] = txtTitle.text
            obj["artist"] = txtArtist.text
            if (!txtYear.text.isEmpty) {
                obj["year"] = txtYear.text.toInt()
            }
            
            obj.saveInBackgroundWithBlock({ (sucess: Bool, error: NSError!) -> Void in
                if error == nil {
                    ParseChanges.sharedInstance.galleryDidChange = true
                    ParseChanges.sharedInstance.artistsDidChange = true
                }
            })
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func btnCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Check (on user edit) if submission is possible
    @IBAction func titleFilled(sender: AnyObject) {
        checkComplete()
    }
    
    // Check (on user edit) if submission is possible
    @IBAction func artistFilled(sender: AnyObject) {
        checkComplete()
    }
    
    
    
}
