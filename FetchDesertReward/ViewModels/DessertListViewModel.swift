//
//  DessertListViewModel.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/21/22.
//

import Foundation
import os

final class DessertListViewModel: ObservableObject {
    
    @Published var dessertList: [Meal] = Desserts.desertPlaceHolder.meals
    
}
