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
                Text("hola")
                
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
    
    
    private func handleNumericButton(_ button: CalculatorButton) {
        let digit = button.rawValue;
        if (shouldResetDisplay) {
            display = digit;
            shouldResetDisplay = false;
        }
    }
    
}

#Preview {
    ContentView()
}
