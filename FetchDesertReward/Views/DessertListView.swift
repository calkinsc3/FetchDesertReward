//
//  DessertListView.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/21/22.
//

import SwiftUI

struct DessertListView: View {
    
    @Environment(\.presentationMode) var prsentationMode
    
    var givenDesserts: [Meal] = Desserts.desertPlaceHolder.meals
    @State private var paths: [Meal] = Desserts.desertPlaceHolder.meals
    
    var body: some View {
        NavigationStack {
            List(givenDesserts){ dessert in
                NavigationLink(value: dessert) {
                    DessertCellView(givenDessert: dessert)
                }
            }
            .navigationDestination(for: Meal.self, destination: { dessert in
                DessertDetailView(dessert: dessert)
            })
            .navigationTitle("Desserts")
            .toolbar {
                Button {
                    prsentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
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
