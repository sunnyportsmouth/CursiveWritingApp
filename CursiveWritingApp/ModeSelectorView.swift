//
//  ModeSelectorView.swift
//  CursiveWritingApp
//
//  Created by Vijay S on 5/26/25.
//

import SwiftUI

struct ModeSelectorView: View {
    var selectedFont: String

    var body: some View {
        VStack(spacing: 30) {
            Text("Choose Mode")
                .font(.title)

            NavigationLink(destination: AlphabetTracingView(selectedFont: selectedFont)) {
                Text("Trace Alphabets")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            NavigationLink(destination: WordTracingView(selectedFont: selectedFont)) {
                Text("Trace Words")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
