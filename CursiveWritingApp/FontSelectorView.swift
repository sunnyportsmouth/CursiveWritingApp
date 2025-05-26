//
//  ContentView.swift
//  CursiveWritingApp
//
//  Created by Vijay S on 5/26/25.
//

import SwiftUI
import AVFoundation

struct FontSelectorView: View {
    
    @State private var selectedFont = "SnellRoundhand-Bold"
    let fontOptions = ["SnellRoundhand-Bold", "Zapfino", "Copperplate"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Select a Cursive Font")
                    .font(.title)
                
                Picker("Font", selection: $selectedFont) {
                    ForEach(fontOptions, id: \.self) { font in
                        Text(font).font(.custom(font, size: 20))
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
                NavigationLink(destination: ModeSelectorView(selectedFont: selectedFont)) {
                    Text("Continue")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}
