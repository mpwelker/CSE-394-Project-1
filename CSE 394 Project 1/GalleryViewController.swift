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
        // Do any additional setup after loading the view, typically from a nib.
        
        artwork = query.findObjects()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}

