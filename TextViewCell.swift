//
//  TextViewCell.swift
//  ExpandingCells
//
//  Created by iwritecode on 6/2/16.
//  Copyright © 2016 iwritecode. All rights reserved.
//

import UIKit

// MARK :- Global constants

let cellId = "idCellTextView"
let nibName = "TextViewCell"

class TextViewCell: UITableViewCell {

    // MARK :- Class properties
    
    // IBOutlet properties
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    // Variables
    class var expandedHeight: CGFloat {
        get { return 200 }
    }
    
    class var defaultHeight: CGFloat {
        get { return 44 }
    }
    
    var frameObserverAdded = false
    
    func checkHeight() {
        textView.hidden = (frame.size.height < TextViewCell.expandedHeight)
    }
    
    
    // MARK :- Property observer and related functions
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    func watchFrameChanges() {
        if !frameObserverAdded {
            addObserver(self, forKeyPath: "frame", options: .New, context: nil)
            checkHeight()
        }
    }
    
    func ignoreFrameChanges() {
        if frameObserverAdded {
            removeObserver(self, forKeyPath: "frame")
            checkHeight()
        }
    }

    // MARK :- Cell Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if cellTitleLabel != nil {
            cellTitleLabel.font = UIFont(name: "Avenir-Medium", size: 14.0)
        }
        
        if textView != nil {
            textView.font = UIFont(name: "Avenir-Light", size: 14.0)
            textView.layer.cornerRadius = 5.0
            textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
