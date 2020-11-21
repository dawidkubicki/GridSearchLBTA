//
//  ContentView.swift
//  GridSearchLBTA
//
//  Created by Dawid Kubicki on 21/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12),
                    GridItem(.flexible(minimum: 100, maximum: 200))
                ],spacing: 10, content: {
                    
                    ForEach(0..<20, id: \.self) { num in
                        ItemView()
                    }
                    
                }).padding(.horizontal, 12)
            }.navigationTitle("Grid Search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ItemView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(width: 100, height: 100)
                .background(Color.blue)
            Text("App title")
                .font(.system(size: 10, weight: .semibold))
            Text("Release Date")
                .font(.system(size: 9, weight: .regular))
            Text("Copyright")
                .font(.system(size: 9, weight: .regular))
                .foregroundColor(.gray)
            
        }
        .padding()
        .background(Color.red)
    }
}
