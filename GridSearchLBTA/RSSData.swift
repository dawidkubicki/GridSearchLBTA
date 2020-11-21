//
//  RSSData.swift
//  GridSearchLBTA
//
//  Created by Dawid Kubicki on 21/11/2020.
//

import Foundation

struct RSS: Decodable{
    let feed: Feed
}

struct Feed:Decodable {
    let results: [Result]
}

struct Result:Decodable, Hashable {
    let copyright, name, artworkUrl100, releaseDate: String
}
