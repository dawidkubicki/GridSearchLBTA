//
//  ContentView.swift
//  GridSearchLBTA
//
//  Created by Dawid Kubicki on 21/11/2020.
//

import SwiftUI
import KingfisherSwiftUI


struct ContentView: View {
    
    @ObservedObject var vm = GridViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12, alignment: .top),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12, alignment: .top),
                    GridItem(.flexible(minimum: 100, maximum: 200), alignment: .top)
                ], alignment: .leading,spacing: 16, content: {
                    
                    ForEach(vm.results, id: \.self) { app in
                        ItemView(appTitle: app.name, appReleaseDate: app.releaseDate, appCopyright: app.copyright, appImage: app.artworkUrl100)
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
    
    var appTitle: String
    var appReleaseDate: String
    var appCopyright: String
    var appImage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
    
            KFImage(URL(string: appImage))
                .resizable()
                .scaledToFit()
                .cornerRadius(22.0)
    
            Text(appTitle)
                .font(.system(size: 10, weight: .semibold))
            Text(appReleaseDate)
                .font(.system(size: 9, weight: .regular))
            Text(appCopyright)
                .font(.system(size: 9, weight: .regular))
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
