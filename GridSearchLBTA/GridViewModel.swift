//
//  GridViewModel.swift
//  GridSearchLBTA
//
//  Created by Dawid Kubicki on 21/11/2020.
//

import SwiftUI

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
