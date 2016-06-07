//
//  ExpandingTableViewController.swift
//  ExpandingCells
//
//  Created by iwritecode on 6/1/16.
//  Copyright © 2016 iwritecode. All rights reserved.
//

import UIKit

// MARK :- Global Constants

class ExpandingTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndexPath: NSIndexPath?

    let tableData = ["About", "Work", "Employment", "Contact"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        registerCells()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableView.visibleCells as! [TextViewCell] {
            cell.ignoreFrameChanges()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK :- Custom functions
    func registerCells() {
        
        tableView.registerNib(UINib(nibName: "TextViewCell", bundle: nil), forCellReuseIdentifier: cellId)

    }

}

// MARK :- UITableView Delegate and Data-Source functions

extension ExpandingTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! TextViewCell
        cell.cellTitleLabel.text = tableData[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths: [NSIndexPath] = []
        
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        
        if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        }
        
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        (cell as! TextViewCell).watchFrameChanges()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        (cell as! TextViewCell).ignoreFrameChanges()
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return TextViewCell.expandedHeight
        } else {
            return TextViewCell.defaultHeight
        }

    }
}


