//
//  ContentView.swift
//  Tip Calculator
//
//  Created by Cullen Steber on 2/2/22.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = ""
    @State private var tipPercentage = 0
    @State private var totalAmount = 0.00
    
    //Initiliaze arr of possible tip percentage values
    private let tipPercentages = [0, 8, 15, 20, 25]
    
    //billAmount is String make sure double val can be used
    private var subTotal: Double {Double (billAmount) ?? 0}
    
    //Calculates and returns tip value
    private var tipValue: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(billAmount) ?? 0
        
        return orderAmount / 100 * tipSelection
    }
    
    //Calculates and returns grand total amount
    private var totalAmountWithTip: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(billAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
    
    var body: some View {
        
        TitleView(title: "Bill Amount")
        TextFieldView(amount: $billAmount)
        
        //Configure Tip % picker
        Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach(0..<tipPercentages.count) {
                Text("\(self.tipPercentages[$0])%")
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(5)
        
        VStack(alignment: .leading, spacing: 0) {
            Text("Grand Total")
                .fontWeight(.black)
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color(UIColor.systemGray5))
                    .cornerRadius(20)
                HStack {
                    Spacer()
                    
                    Text("$\(totalAmountWithTip, specifier: "%.2f")")
                        .foregroundColor(.white)
                        .font(.system(size: 45, weight: .black, design: .monospaced))
                        .fontWeight(.black)
                    
                    Spacer()
                    
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemGray3))
                        .frame(width: 1, height: 70)
                    
                    Spacer()
                    

                    VStack (alignment: .leading, spacing: 15){
                        VStack(alignment: .leading){
                                Text("Amount Tipped")
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.light)
                                    
                                Text("$ \(tipValue, specifier: "%.2f")")
                                    .font(.system(.body, design:.monospaced))
                                    .fontWeight(.black)
                        }
                        .padding(.trailing, 25.0)
                            
                        }
                        
                    }.foregroundColor(.white)
                    
                    Spacer()
            }
                .padding(5)
            }.frame(width: 375, height: 150)
        
    }
}

//Configure view for titles
struct TitleView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.black)
            Spacer()
        }
    }
}

//Configure view for bill textfield entry
struct TextFieldView: View {
    var amount: Binding<String>
    var body: some View {
        HStack {
            Text("$")
                .foregroundColor(.primary)
                .font(.system(size: 60, weight: .black, design: .rounded))
            TextField("Amount", text: amount)
                .foregroundColor(.primary)
                .font(.system(size: 60, weight: .black, design: .rounded))
                .keyboardType(.decimalPad)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
