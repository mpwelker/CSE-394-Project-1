//
//  ArtistsViewController.swift
//  CSE 394 Project 1
//
//  Created by Michael Welker on 2/26/15.
//  Copyright (c) 2015 Michael Welker. All rights reserved.
//

import UIKit
import Parse

class ArtistsViewController : UITableViewController {
    
    var artistNames = NSMutableArray()
    var numOfPieces = [Int]()
    let query = PFQuery(className: "Artwork")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //initArtists()
        
        /*
        query.orderByAscending("artist").findObjectsInBackgroundWithBlock {
            (names: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
                if let names = names as? [PFObject] {
                    for name in names {
                        if (self.artists.containsObject(name["artist"])) {
                            //self.pieces[self.artists.indexOfObject(name["artists"])] = (self.pieces[self.artists.indexOfObject(name["artists"])] + 1) as Int
                        } else {
                            self.artists.addObject(name["artist"] as NSString)
                            //self.pieces.addObject(1 as Int)
                        }
                    }
                }
            } else {
                NSLog("Couldn't retrieve artists")
            }
        }
        NSLog("%@", artists)
        */
        
        
        
        
        /*
        // This is pulling more than it should and is gross and I don't like it
        // but selectKeys is acting funny for me...
        var temp = NSMutableArray()
        artwork = query.findObjects()
        for art in artwork {
            if let art = art as? PFObject {
                temp.addObject(art["artist"])
            }
        }
        var ordered = NSOrderedSet(array: temp)
        artists = ordered.sortedArrayUsingComparator({ (a: AnyObject!, b: AnyObject!) -> NSComparisonResult in
            return (a as NSString).caseInsensitiveCompare(b as NSString)
        })
        NSLog("%@", artists)
        */
        
        
        
        
        // This is just gross.
        /*query.selectKeys(["artist"]).findObjectsInBackgroundWithBlock {
            (names: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
                if let names = names as? [PFObject] {
                    for name in names {
                        self.artists.addObject(name["artists"] as NSString)
                        //NSLog("%@", object["artist"] as NSString)
                    }
                }
            }
        }
        NSLog("%@", artists)*/
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // reload automatically if there have been changes to the database
        if ParseChanges.sharedInstance.artistsDidChange {
            ParseChanges.sharedInstance.artistsDidChange = false
            self.refreshTable(self)
        }
    }
    
    // Construct the array of artists and also the array of counts for their respective pieces
    func initArtists() {
        self.refreshTable(self)
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            for piece in self.query.orderByAscending("artist").findObjects() {
//                if let piece = piece as? PFObject {
//                    if (self.artists.containsObject(piece["artist"])) {
//                        self.pieces[self.artists.indexOfObject(piece["artist"])] =
//                            (self.pieces[self.artists.indexOfObject(piece["artist"])] as Int) + 1
//                    } else {
//                        self.artists.append(piece)
//                        self.pieces.append(1)
//                    }
//                }
//            }
//            dispatch_async(dispatch_get_main_queue(), {
//                self.tableView.reloadData()
//            })
//        })
        //NSLog("%@", artists)
        //NSLog("%@", pieces)
    }
    
    // Length of transaction list tied to length of transactions array
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistNames.count
    }
    
    @IBAction func refreshTable(sender: AnyObject) {
        self.query.orderByAscending("artist")
        (sender as? UIRefreshControl)?.beginRefreshing()
        self.query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                self.artistNames.removeAllObjects()
                self.numOfPieces.removeAll(keepCapacity: false)
                for object in objects as [PFObject] {
                    if self.artistNames.containsObject(object["artist"]) {
                        let index = self.artistNames.indexOfObject(object["artist"])
                        self.numOfPieces[index]++
                    } else {
                        self.artistNames.addObject(object["artist"] as NSString)
                        self.numOfPieces.append(1)
                    }
                }
                self.tableView.reloadData()
                (sender as? UIRefreshControl)?.endRefreshing()
            }
        }
    }
    
    // Contruct the cell with transaction, amount, and remaining balance.
    // Also alternate background colors and handle text highlights.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = artistNames[indexPath.row] as NSString
        cell.detailTextLabel?.text = String(numOfPieces[indexPath.row])
        
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
        
        let dest = segue.destinationViewController as ArtistDetailTableViewController
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            dest.artistName = artistNames[indexPath.row] as NSString
        }
    }
    
}