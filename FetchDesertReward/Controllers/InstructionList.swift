//
//  InstructionList.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/20/22.
//

import UIKit

class InstructionList: UITableViewController {
    
    var givenInstructions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - TableView Data
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.givenInstructions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let instructionCell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath) as? InstructionCell else {
            return UITableViewCell()
        }
        
        //set instruction
        instructionCell.instructionText.text = self.givenInstructions[indexPath.row]
        
        return instructionCell
    }
    
}
