//
//  ViewController.swift
//  FilterTableViewWithButton
//
//  Created by G R-Titko on 10/30/18.
//  Copyright © 2018 GRT-Programs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mineralTableView: UITableView!
    
    var currentFilter: String = "" {
        didSet {
            if mineralTableView != nil {
              mineralTableView.reloadData()
            }
        }
    }
    
    var minerals: [MineralModel] = []
    var filterButtonCounter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        minerals = MineralModel.populateMinerals()
    }

    var filteredMineral: [MineralModel] {
        if currentFilter == "animal" {
            return minerals.filter({ (mineral) -> Bool in
                return mineral.mineralType == "animal"
            })
        }
        if currentFilter == "mineral" {
            return minerals.filter({ (mineral) -> Bool in
                return mineral.mineralType == "mineral"
            })
        }
        if currentFilter == "thing" {
            return minerals.filter({ (mineral) -> Bool in
                return mineral.mineralType == "thing"
            })
        }
        return minerals
    }
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        filterButtonCounter += 1
        switch filterButtonCounter {
        case 1:
            sender.title = "All"
            currentFilter = "All"
        case 2:
            sender.title = "Animal"
            currentFilter = "animal"
        case 3:
            sender.title = "Mineral"
            currentFilter = "mineral"
        case 4:
            sender.title = "Thing"
            currentFilter = "thing"
            filterButtonCounter = 0
        default:
            print("No other options exist")
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMineral.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineralCell", for: indexPath) as! MineralTableViewCell
        
        let mineral = filteredMineral[indexPath.row]
        cell.leftImage.image = mineral.mainImage
        cell.labelType.text = mineral.mineralType
        return cell
    }
    
}


