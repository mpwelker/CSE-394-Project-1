//
//  FavoritesTableViewController.swift
//  CSE 394 Project 1
//
//  Created by Dana Johnson on 4/6/15.
//  Copyright (c) 2015 Michael Welker. All rights reserved.
//

import UIKit
import Parse

class FavoritesTableViewController: UITableViewController {

    var favoritePieces = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        if ParseChanges.sharedInstance.favoritesDidChange {
            ParseChanges.sharedInstance.favoritesDidChange = false
            let query = PFQuery(className: "Artwork")
            query.whereKey("favorite", equalTo: true)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    for object in objects as [PFObject] {
                        if contains(self.favoritePieces, object) {
                        }
                    }
                    self.favoritePieces.removeAll(keepCapacity: false)
                    for object in objects as [PFObject] {
                        self.favoritePieces.append(object)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoritePieces.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("favoritesCell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = self.favoritePieces[indexPath.row]["title"] as NSString
        cell.detailTextLabel?.text = self.favoritePieces[indexPath.row]["artist"] as NSString

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let dest = segue.destinationViewController as PieceDetailViewController
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            dest.piece = self.favoritePieces[indexPath.row]
        }
    }

}
