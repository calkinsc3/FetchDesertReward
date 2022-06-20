//
//  IngredientCell.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/20/22.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    
    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var ingredientQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
