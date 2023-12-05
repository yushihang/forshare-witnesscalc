//
//  ContentView.swift
//  testSwift
//
//  Created by yushihang on 2023/11/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button {
                
                let wasmBytes =  Data(repeating: 1, count: 100)
                let inputsJsonBytes =  Data(repeating: 1, count: 100)

                let data = calculateWitnessAuth(wasmBytes: wasmBytes, inputsJsonBytes: inputsJsonBytes)
                print("data: \(String(describing: data))")
            } label: {
                Text("123")
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
