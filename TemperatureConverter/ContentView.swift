//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Barry Martin on 5/10/20.
//  Copyright © 2020 Barry Martin. All rights reserved.
//
// Challenge
// You need to build an app that handles unit conversions: users will select an
// input unit and an output unit, then enter a value, and see the output of the conversion
// Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    @State private var inputValue = "0"
    
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    private var inputTemp: Double {
        return  Double(inputValue) ?? 0
    }
    
    private var outputTemp: Double {
        var temperature = Measurement(value: 0, unit: UnitTemperature.celsius)
        switch temperatureUnits[inputUnit] {
        case "Celsius":
            temperature = Measurement(value: inputTemp, unit: UnitTemperature.celsius)
        case "Fahrenheit":
            temperature = Measurement(value: inputTemp, unit: UnitTemperature.fahrenheit)
        case "Kelvin":
            temperature = Measurement(value: inputTemp, unit: UnitTemperature.kelvin)
        default:
            print ("Unexpected temperature type temperatureUnits[inputUnit]")
        }
        
        switch temperatureUnits[outputUnit] {
        case "Celsius":
            let celsius = temperature.converted(to: UnitTemperature.celsius)
            return celsius.value
        case "Fahrenheit":
            let fahrenheit = temperature.converted(to: UnitTemperature.fahrenheit)
            return fahrenheit.value
        case "Kelvin":
            let kelvin = temperature.converted(to: UnitTemperature.kelvin)
            return kelvin.value
        default:
            return 0
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter input value:")) {
                    TextField("0", text: $inputValue)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Pick an input unit:")) {
                    Picker("Temp unit:", selection: $inputUnit) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Pick an output unit:")) {
                    Picker("Temp unit:", selection: $outputUnit) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Result of conversion:")) {
                    Text("\(outputTemp, specifier: "%.2f") degrees")
                }
            }
            .navigationBarTitle("Temperature Convert")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
