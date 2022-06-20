//
//  InstructionCell.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/20/22.
//

import UIKit

class InstructionCell: UITableViewCell {
    
    
    @IBOutlet weak var instructionText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
