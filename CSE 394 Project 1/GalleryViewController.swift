//
//  GalleryViewController.swift
//  CSE 394 Project 1
//
//  Created by Michael Welker on 2/19/15.
//  Copyright (c) 2015 Michael Welker. All rights reserved.
//

import UIKit
import Parse

class GalleryViewController: UITableViewController {
    
    // Early test data, ignore...
    //let titles : NSArray = ["Mona Lisa", "Starry Night", "Great Wave Off Kanagawa", "No. 5", "The Birth of Venus"]
    //let artists : NSArray = ["Leonardo da Vinci", "Vincent Van Gogh", "Katsushika Hokusai", "Jackson Pollack", "Sandro Botticelli"]
    //let years : NSArray = ["1517", "1889", "1829", "1948", "1486"]

    var artwork = NSArray()
    let query = PFQuery(className: "Artwork")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        if ParseChanges.sharedInstance.galleryDidChange {
            ParseChanges.sharedInstance.galleryDidChange = false
            self.query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    self.artwork = objects
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // Length of transaction list tied to length of transactions array
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artwork.count
    }
    
    // Contruct the cell with transaction, amount, and remaining balance.
    // Also alternate background colors and handle text highlights.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = (artwork[indexPath.row]["title"] as NSString)
        cell.detailTextLabel?.text = (artwork[indexPath.row]["artist"] as NSString)

        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // just a subtle effect
        cell.alpha = 0.0
        UIView.animateWithDuration(0.3) {
            cell.alpha = 1.0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as PieceDetailViewController
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            dest.piece = artwork[indexPath.row] as PFObject
        }
    }

}

