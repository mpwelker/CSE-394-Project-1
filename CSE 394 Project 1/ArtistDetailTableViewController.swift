//
//  ArtistDetailTableViewController.swift
//  CSE 394 Project 1
//
//  Created by Dana Johnson on 4/5/15.
//  Copyright (c) 2015 Michael Welker. All rights reserved.
//

import UIKit
import Parse

class ArtistDetailTableViewController: UITableViewController {

    var artistName: NSString!
    private var artwork = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.artistName
        let query = PFQuery(className: "Artwork")
        query.whereKey("artist", equalTo: artistName)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects as [PFObject] {
                    self.artwork.append(object)
                }
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artwork.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("artistNameCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = self.artwork[indexPath.row]["title"] as NSString

        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // just a subtle effect
        cell.alpha = 0.0
        UIView.animateWithDuration(0.3) {
            cell.alpha = 1.0
        }
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let dest = segue.destinationViewController as PieceDetailViewController
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            dest.piece = self.artwork[indexPath.row]
        }
    }

}
