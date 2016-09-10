//
//  ExploreViewController.swift
//  TraitifyExplore
//
//  Created by Tom Prats on 4/1/16.
//  Copyright © 2016 Tomify. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var decks: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(DeckCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
        if !getDecks() {
            displayError()
        }
    }
    
    func getDecks() -> Bool {
        Traitify.getDecks({ (data, response, error) in
            do {
                self.decks = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [NSDictionary]
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            } catch  { self.displayError() }
        })
        return true
    }
    
    func displayError() {
        self.decks = [["name": "Error", "personality_types": []]]
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    // TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeckCell", forIndexPath: indexPath) as! DeckCell
        let deck = decks[indexPath.row]
        cell.nameLabel.text = deck["name"] as? String
        cell.deck = deck
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! DeckViewController
        let cell = sender as! DeckCell
        viewController.deck = cell.deck
    }
}