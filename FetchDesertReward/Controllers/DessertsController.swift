//
//  DesertsController.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import UIKit

class DessertsController:  UITableViewController  {
    
    let desertViewModel = DessertsViewModel()
    let pullToRefresh = UIRefreshControl()
    
    private var deserts : [Meal] = []
    private var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 60.0
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.gatherDeserts()
        
        self.setUpPullToRefresh()
        
    }
    
    // MARK: - Helpers
    private func gatherDeserts() {
        Task {
            do {
                let gatheredDeserts = try await self.desertViewModel.getDeserts()
                self.deserts = gatheredDeserts.meals.sorted(by: {$0.strMeal < $1.strMeal})
                tableView.reloadData()
            } catch {
                Log.networkLogger.error("Unable to retrieve deserts from API")
            }
        }
    }
    
    private func setUpPullToRefresh() {
        self.tableView.refreshControl = self.pullToRefresh
        self.pullToRefresh.addTarget(self, action: #selector(DessertsController.refresh(sender:)), for: .valueChanged)
    }
    
    @objc func refresh(sender: AnyObject) {
        self.gatherDeserts()
        self.pullToRefresh.endRefreshing()
    }
    
    
    // MARK: - TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deserts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let desertCell = tableView.dequeueReusableCell(withIdentifier: "desertCellID", for: indexPath) as? DessertCell else {
            return UITableViewCell()
        }
        
        if self.deserts.indices.contains(indexPath.row) { //protect the subscript
            desertCell.desertName.text = self.deserts[indexPath.row].strMeal
            if let imageURL = URL(string: self.deserts[indexPath.row].strMealThumb) {
                desertCell.imageURL = imageURL //Need to set for prepareForReuse
                desertCell.getDessertImage()
            }
        }
        
        return desertCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath
        self.performSegue(withIdentifier: "desertDetailsSegue", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "desertDetailsSegue",
              let dessertDetailsVC = segue.destination as? ViewController,
              let selectedIndex = self.selectedIndex else {
            return
        }
        
        if self.deserts.indices.contains(selectedIndex.row) {
            dessertDetailsVC.givenDessert = self.deserts[selectedIndex.row]
            self.selectedIndex = nil
        }
    }
    
    @IBSegueAction func ingredientListViewSegue(_ coder: NSCoder) -> UIViewController? {
        return DessertListHosting(coder: coder, rootView: DessertListView(givenDesserts: self.deserts))
    }
    
    
}
