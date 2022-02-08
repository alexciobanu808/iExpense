//
//  ContentView.swift
//  iExpense
//
//  Created by Alex Ciobanu on 2/3/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if isPersonal(type: item.type) {
                            ZStack {
                                LinearGradient(gradient: Gradient(colors: [determineBackgronudColor(cost: item.amount), .white]), startPoint: .trailing, endPoint: .leading)
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: "USD"))
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section("Business") {
                    ForEach(expenses.items) { item in
                        if !isPersonal(type: item.type) {
                            ZStack {
                                LinearGradient(gradient: Gradient(colors: [determineBackgronudColor(cost: item.amount), .white]), startPoint: .trailing, endPoint: .leading)
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: "USD"))
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
            }
            .navigationBarTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func isPersonal(type: String) -> Bool {
        if type == "Personal" {
            return true
        } else {
            return false
        }
    }
    
    func determineBackgronudColor(cost: Double) -> Color {
        if cost <= 10.0 {
            return Color.green
        } else if cost <= 100.0 {
            return Color.yellow
        } else {
            return Color.red
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
