//
//  DeckViewController.swift
//  TraitifyExplore
//
//  Created by Tom Prats on 9/9/16.
//  Copyright © 2016 Tomify. All rights reserved.
//

import UIKit
import SwiftHEXColors

class DeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var deck: NSDictionary = ["name": "None"]
    var imageCache: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(TypeCell.self, forCellReuseIdentifier: "cell")
        self.nameLabel.text = deck["name"] as? String
    }
    
    // TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deck["personality_types"]!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TypeCell", forIndexPath: indexPath) as! TypeCell
        let type = deck["personality_types"]![indexPath.row]
        cell.nameLabel.text = type["name"] as? String
        cell.descriptionLabel.text = type["description"] as? String
        let color = type["badge"]!!["color_1"] as! String
        cell.contentView.backgroundColor = UIColor(hexString: color)
        return cell
    }
}
