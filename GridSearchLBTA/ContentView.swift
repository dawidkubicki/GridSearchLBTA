//
//  ContentView.swift
//  GridSearchLBTA
//
//  Created by Dawid Kubicki on 21/11/2020.
//

import SwiftUI
import KingfisherSwiftUI

struct RSS: Decodable{
    let feed: Feed
}

struct Feed:Decodable {
    let results: [Result]
}

struct Result:Decodable, Hashable {
    let copyright, name, artworkUrl100, releaseDate: String
}



class GridViewModel: ObservableObject {
    
    @Published var items = 0..<5
    @Published var results = [Result]()
    
    init() {
        // json decoding simulation
//        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
//            self.items = 0..<15
            guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/pl/ios-apps/top-free/all/10/explicit.json") else {
                return
            }
            URLSession.shared.dataTask(with: url) { (data, resp, error) in
                // check error response status and err
                guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode(RSS.self, from: data)
                print(rss)
                DispatchQueue.main.async {
                    self.results = rss.feed.results
                }
            } catch {
                print("Failed to decode: \(error)")
            }
                
    }.resume()
    }
}


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
