//
//  ContentView.swift
//  TestVisionOS
//
//  Created by Paul Nguon on 6/22/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @StateObject private var calculator = Calculator()
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .flipSign, .percentage, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        NavigationSplitView {
            List {
                Text("Item")
                Text("Item 2")
            }
            .navigationTitle("Sidebar")
        } detail: {
            VStack {
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)
                HStack {
                    /* Display values */
                    Spacer()
                    Text(calculator.display)
                        .font(.system(size: 40))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                }
                ForEach(buttons, id: \.self ){
                    row in HStack {
                        ForEach(row, id: \.self){
                            button in Button {
                                calculator.handleButton(button)
                            } label: {
                                Text(button.rawValue)
                                    .font(.title)
                                    .frame(width: 50, height: 75)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Content")
            .padding()
        }
    }
}

enum CalculatorButton: String {
    case zero = "0", one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9"
    case decimal = ".", equals = "=", plus = "+", minus = "-", multiply = "X", divide = "/"
    case clear = "AC", flipSign = "+/-", percentage = "%"
    
}

class Calculator: ObservableObject {
   @Published var display = "0";
    
    private var firstOperand: Double = 0;
    private var secondOperand: Double = 0;
    private var shouldResetDisplay = false;
    
    
    func handleButton(_ button: CalculatorButton) {
        
        switch button {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            handleNumericButton(button)
        case .clear:
            handleClearButton()
        case .decimal:
            if(!display.contains(".")) {
                display += "."
            }
        default:
            print("Reached end of switch")
        }
    }
    
    private func handleNumericButton(_ button: CalculatorButton) {
        let digit = button.rawValue;
        if (shouldResetDisplay) {
            display = digit;
            shouldResetDisplay = false;
        }
        else {
            display += digit;
        }
    }
    
    private func handleClearButton() {
        display = "0"
        firstOperand = 0
        secondOperand = 0
    }
    
}

#Preview {
    ContentView()
}
