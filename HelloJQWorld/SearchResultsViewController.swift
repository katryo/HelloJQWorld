//
//  ViewController.swift
//  HelloJQWorld
//
//  Created by RYOKATO on 2015/02/03.
//  Copyright (c) 2015年 Denkinovel. All rights reserved.
//
// http://jamesonquave.com/blog/developing-ios-apps-using-swift-tutorial-part-2/

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
    @IBOutlet var appsTableView: UITableView?
    var tableData = []
    var api = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()
        api.searchItunesFor("JQ Software")
        api.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        return tableData.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        cell.textLabel?.text = rowData["trackName"] as? String
        let urlString: NSString = rowData["artworkUrl60"] as NSString
        let imgURL: NSURL? = NSURL(string: urlString)
        
        let imgData = NSData(contentsOfURL: imgURL!)
        cell.imageView?.image = UIImage(data: imgData!)
        let formattedPrice: NSString = rowData["formattedPrice"] as NSString
        cell.detailTextLabel?.text = formattedPrice
   
        return cell
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        var resultsArr: NSArray = results["results"] as NSArray
        println(resultsArr)
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = resultsArr
            self.appsTableView!.reloadData()
        })
    }
 }

