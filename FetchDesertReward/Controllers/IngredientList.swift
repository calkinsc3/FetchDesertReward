//
//  IngredientList.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/20/22.
//

import UIKit

class IngredientList: UITableViewController {
    
    var ingredients: [MealIngredients] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 55.0
        self.tableView.rowHeight = UITableView.automaticDimension

    }

    // MARK: - TableView Data
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingredients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? IngredientCell else {
            return UITableViewCell()
        }
        
        if self.ingredients.indices.contains(indexPath.row) {
            ingredientCell.ingredientName.text = self.ingredients[indexPath.row].name
            ingredientCell.ingredientQuantity.text = self.ingredients[indexPath.row].quantity
        }
       
        return ingredientCell
    }
    
}
