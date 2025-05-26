//
//  WordTracingView.swift
//  CursiveWritingApp
//
//  Created by Vijay S on 5/26/25.
//

import SwiftUI

struct WordTracingView: View {
    var selectedFont: String
    @State private var currentDrawing = Drawing()
    @State private var drawings: [Drawing] = []
    @State private var currentWord = ""

    let words = [
        "apple", "banana", "cherry", "elephant", "giraffe", "house",
        "island", "jungle", "kite", "lemon", "monkey", "notebook",
        "orange", "pencil", "queen", "rainbow", "sun", "tree", "umbrella",
        "violin", "whale", "xylophone", "yogurt", "zebra"
    ]

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                // Notebook-style lines
                VStack(spacing: 60) {
                    Rectangle().frame(height: 2).foregroundColor(.gray)
                    Rectangle().frame(height: 2).foregroundColor(.gray)
                }.padding(.horizontal)

                // Word background
                Text(currentWord)
                    .font(.custom(selectedFont, size: 80))
                    .foregroundColor(.gray.opacity(0.3))
            }
            .frame(height: 200)
            .overlay(
                ZStack {
                    ForEach(drawings) { drawing in
                        Path { path in
                            add(drawing: drawing, toPath: &path)
                        }
                        .stroke(Color.blue, lineWidth: 4)
                    }

                    Path { path in
                        add(drawing: currentDrawing, toPath: &path)
                    }
                    .stroke(Color.red, lineWidth: 4)
                }
            )
            .gesture(DragGesture(minimumDistance: 0.1)
                .onChanged { value in
                    currentDrawing.points.append(value.location)
                }
                .onEnded { _ in
                    drawings.append(currentDrawing)
                    currentDrawing = Drawing()
                })

            Text("Trace the word: \"\(currentWord.capitalized)\"")
                .font(.body)
                .foregroundColor(.gray)

            HStack {
                Button("Clear") {
                    drawings = []
                }
                .padding()

                Button("Next Word") {
                    getNextWord()
                }
                .padding()
            }
        }
        .padding()
        .onAppear {
            getNextWord()
        }
    }

    private func getNextWord() {
        currentWord = words.randomElement() ?? "hello"
        drawings = []
    }

    private func add(drawing: Drawing, toPath path: inout Path) {
        guard let firstPoint = drawing.points.first else { return }
        path.move(to: firstPoint)
        for point in drawing.points.dropFirst() {
            path.addLine(to: point)
        }
    }
}
