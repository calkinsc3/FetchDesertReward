//
//  DessertListView.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/21/22.
//

import SwiftUI

struct DessertListView: View {
    
    @StateObject var dessertListViewModel = DessertListViewModel()
    
    var body: some View {
        NavigationView {
            List(self.dessertListViewModel.dessertList){ dessert in
                DessertCellView(givenDessert: dessert)
            }
            .navigationTitle("Desserts")
        }
        
    }
}

struct DessertCellView: View {
    
    let givenDessert: Meal
    
    var body: some View {
        HStack(alignment: .center, spacing: 20.0) {
            AsyncImage(url: self.givenDessert.thumbNailURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50, alignment: .leading)
            } placeholder: {
                ProgressView()
            }
            Text(givenDessert.strMeal)
        }
    }
}


// MARK: - Previews
struct DessertListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
    }
}
