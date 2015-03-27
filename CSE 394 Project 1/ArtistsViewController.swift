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
    
    var artists = NSMutableArray()
    var pieces = [Int]()
    let query = PFQuery(className: "Artwork")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initArtists()
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Construct the array of artists and also the array of counts for their respective pieces
    func initArtists() {
        var temp = NSMutableArray()
        for piece in query.orderByAscending("artist").findObjects() {
            if let piece = piece as? PFObject {
                if (artists.containsObject(piece["artist"])) {
                    pieces[artists.indexOfObject(piece["artist"])] =
                        (pieces[artists.indexOfObject(piece["artist"])] as Int) + 1
                } else {
                    artists.addObject(piece["artist"])
                    pieces.append(1)
                }
            }
        }
        //NSLog("%@", artists)
        //NSLog("%@", pieces)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    // Length of transaction list tied to length of transactions array
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return artists.count
    }
    
    // Contruct the cell with transaction, amount, and remaining balance.
    // Also alternate background colors and handle text highlights.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = artists[indexPath.row] as NSString
        cell.detailTextLabel?.text = String(pieces[indexPath.row])
        
        return cell
    }
    
}