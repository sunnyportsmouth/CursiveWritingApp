import SwiftUI

struct AlphabetTracingView: View {
    var selectedFont: String
    @State private var letterIndex = 0
    @State private var currentDrawing = Drawing()
    @State private var drawings: [Drawing] = []

    let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map { String($0) }

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                // Simulate notebook lines
                VStack(spacing: 60) {
                    Rectangle().frame(height: 2).foregroundColor(.gray)
                    Rectangle().frame(height: 2).foregroundColor(.gray)
                }.padding(.horizontal)

                // Letter background
                Text(letters[letterIndex])
                    .font(.custom(selectedFont, size: 220))
                    .foregroundColor(.gray.opacity(0.3))
            }
            .frame(height: 300)
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

            // Instruction and buttons
            Text("Start at the top left of the letter \(letters[letterIndex])")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.bottom)

            HStack {
                Button("Clear") {
                    drawings = []
                }
                .padding()

                Button("Next Letter") {
                    letterIndex = (letterIndex + 1) % letters.count
                    drawings = []
                }
                .padding()
            }
        }
        .padding()
    }

    private func add(drawing: Drawing, toPath path: inout Path) {
        guard let firstPoint = drawing.points.first else { return }
        path.move(to: firstPoint)
        for point in drawing.points.dropFirst() {
            path.addLine(to: point)
        }
    }
}

// Shared Drawing model
struct Drawing: Identifiable {
    let id = UUID()
    var points: [CGPoint] = []
}
