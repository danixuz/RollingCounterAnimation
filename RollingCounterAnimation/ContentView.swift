//
//  ContentView.swift
//  RollingCounterAnimation
//
//  Created by Daniel Spalek on 08/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State var value: Int = 111
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 25){
                    RollingText(font: .system(size: 55), weight: .black, value: $value)
                        .padding(.top, 200)
                    
                    // Change value to random number button
                    Button("Change Value") {
                        value = .random(in: 0...9999)
                    }
                    .buttonStyle(.bordered)
                    .tint(colorScheme == .dark ? .green : .blue)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Rolling Counter")
                .toolbar(.visible)
                .padding()
            }
            .background{
                LinearGradient(colors: [
                    .blue.opacity(0.8),
                    .cyan.opacity(0.6),
                    .green.opacity(0.5)
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme(.dark)
    }
}
