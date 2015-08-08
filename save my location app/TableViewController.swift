//
//  TableViewController.swift
//  save my location app
//
//  Created by lapacino on 8/8/15.
//  Copyright (c) 2015 lapacino. All rights reserved.
//

import UIKit

  var places = [Dictionary<String,String>()]
  var activePlaces = 0

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if places.count == 1 {
            
            places.removeAtIndex(0)
        }
        
        if places.count == 0 {
            places.append(["name": "Taj Mahal", "lat": "27.175268", "lon": "78.042182"])
        }

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showAdd" {
            activePlaces = -1
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return places.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        activePlaces = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        cell.textLabel?.text = places[indexPath.row]["name"]
        return cell
    }



}
