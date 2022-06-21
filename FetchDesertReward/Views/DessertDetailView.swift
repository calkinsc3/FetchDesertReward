//
//  DessertDetailView.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/21/22.
//

import SwiftUI

struct DessertDetailView: View {
    
    @State private var showingInstructions = false
    @State private var showingIngredients = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("BananaPancakes")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
            Text("Dessert Name")
                .font(.headline)
            
            Button {
                self.showingInstructions = true
            } label: {
                Label("Baking Instructions", systemImage: "list.bullet")
            }
            Button {
                self.showingIngredients = true
            } label: {
                Label("Baking Ingredients", systemImage: "list.dash.header.rectangle")
            }

            Spacer()
            
        }
    }
}

struct InstructionsList: View {
    
    let instructions: [String]
    
    var body: some View {
        
        List(self.instructions, id: \.self) { instruction in
            Text(instruction)
                .font(.body)
        }
    }
}

struct IngredientListView: View {
    
    let ingredients: [MealIngredients]
    
    var body: some View {
        List(self.ingredients) { ingredient in
            IngredientView(ingredient: ingredient)
        }
    }
}

struct IngredientView: View {
    
    let ingredient: MealIngredients
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text(ingredient.name)
            Text(ingredient.quantity)
        }
    }
    
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView()
    }
}
