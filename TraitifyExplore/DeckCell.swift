//
//  DeckCell.swift
//  TraitifyExplore
//
//  Created by Tom Prats on 4/9/16.
//  Copyright © 2016 Tomify. All rights reserved.
//

import UIKit

class DeckCell: UITableViewCell {
    @IBOutlet weak var paddedView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var deck: NSDictionary = ["name": "None"]
    
    override func awakeFromNib() {
        paddedView.layer.cornerRadius = 25
    }
}