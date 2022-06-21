//
//  DessertDetailView.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/21/22.
//

import SwiftUI

enum CurrentSheetShowing {
    case instructions, ingredients
    
    init() {
        self = .instructions
    }
}

struct DessertDetailView: View {
    
    @State private var showingDetailsSheet = false
    @State private var currentSheet = CurrentSheetShowing()
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("BananaPancakes")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
            Text("Dessert Name")
                .font(.headline)
            
            Button {
                self.showingDetailsSheet = true
                self.currentSheet = .instructions
            } label: {
                Label("Baking Instructions", systemImage: "list.bullet")
            }
            Button {
                self.showingDetailsSheet = true
                self.currentSheet = .ingredients
            } label: {
                Label("Baking Ingredients", systemImage: "list.dash.header.rectangle")
            }
            Spacer()
        }
        .sheet(isPresented: $showingDetailsSheet) {
            self.showingDetailsSheet = false
        } content: {
            if self.currentSheet == .instructions {
                InstructionsList(instructions: ["Instruction1", "Instruction2", "Instruction3", "Instruction4", "Instruction5"], showSheet: $showingDetailsSheet)
            }
            if self.currentSheet == .ingredients {
                IngredientListView(ingredients: [MealIngredients(name: "Sugar", quantity: "10 cups"), MealIngredients(name: "Flour", quantity: "5 cups"), MealIngredients(name: "Oil", quantity: "1 cup")], dismiss: $showingDetailsSheet)
            }
        }

    }
}

struct InstructionsList: View {
    
    let instructions: [String]
    @Binding var showSheet: Bool
    
    var body: some View {
        
        VStack {
            Button {
                self.showSheet = false
            } label: {
                Image(systemName: "xmark")
            }

            List(self.instructions, id: \.self) { instruction in
                Text(instruction)
                    .font(.body)
            }
        }
    }
}

struct IngredientListView: View {
    
    let ingredients: [MealIngredients]
    @Binding var dismiss: Bool
    
    var body: some View {
        
        VStack {
            Button {
                self.dismiss = false
            } label: {
                Image(systemName: "xmark")
            }
            List(self.ingredients) { ingredient in
                IngredientView(ingredient: ingredient)
            }
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
