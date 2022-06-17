//
//  DesertsController.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import UIKit

class DessertsController:  UITableViewController  {
    
    let desertViewModel = DessertsViewModel()
    
    private var deserts : [Meal] = []
    private var selectedDessert: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gatherDeserts()
        
    }
    
    // MARK: - Helpers
    private func gatherDeserts() { // TODO: May need to replace with a closure
        Task {
            do {
                let gatheredDeserts = try await self.desertViewModel.getDeserts()
                self.deserts = gatheredDeserts.meals
                tableView.reloadData()
            } catch {
                Log.networkLogger.error("Unable to retrieve deserts from API")
            }
        }
    }
    
    
    // MARK: - TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return self.desertViewModel.placeHolderDeserts.meals.count
        return self.deserts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let desertCell = tableView.dequeueReusableCell(withIdentifier: "desertCellID", for: indexPath) as? DessertCell else {
            return UITableViewCell()
        }
        
        //desertCell.desertName.text = self.desertViewModel.deserts.meals[indexPath.row].strMeal
        if self.deserts.indices.contains(indexPath.row) { //protect the subscript
            desertCell.desertName.text = self.deserts[indexPath.row].strMeal
        }
        
        return desertCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.deserts.indices.contains(indexPath.row) {
            // FIXME: Index is wrong
            self.selectedDessert = self.deserts[indexPath.row]
        }

    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "desertDetailsSegue", let dessertDetailsVC = segue.destination as? ViewController {
            // FIXME: wrong dessert is being sent
            dessertDetailsVC.givenDessert = self.selectedDessert
        }
    }
    
}
