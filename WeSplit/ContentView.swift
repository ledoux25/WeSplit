//
//  ContentView.swift
//  WeSplit
//
//  Created by Sanguo Joseph Ledoux on 8/23/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount : Double? = nil
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocussed : Bool
    
    var valuePerPerson : Double {
        
        if let checkAmount = checkAmount {
            var totalAmount = checkAmount + checkAmount/100 * Double(tipPercentage)
            print(totalAmount)
            
            return totalAmount / Double(numberOfPeople)
        }
        return 0.0
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var body: some View{
        NavigationStack {
            Form{
                
                Section("Check Amount")
                    {
                        
                        
                        TextField(
                            "$0.00",
                            value: $checkAmount,
                            format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocussed)
                    
                    
                    
                    
                    Picker("Number of people", selection: $numberOfPeople,){
                        ForEach(2 ..< 100, id: \.self){
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave ? "){
                    Picker("Select Tip",  selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                VStack(alignment: .center, spacing: 0.0,){
                    Text(valuePerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).font(.system(size: 45.0))
                    Text("/person").foregroundColor(Color.gray)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).padding(.vertical, 45)
            }
            
            .toolbar{
                ToolbarItem(placement: .keyboard){
                    if amountIsFocussed{
                        Button("done"){
                            amountIsFocussed = false
                        }
                    }
                }
                
            }
            .navigationTitle("Wesplit")
            
        }
        
    }
}

#Preview {
    ContentView()
}
