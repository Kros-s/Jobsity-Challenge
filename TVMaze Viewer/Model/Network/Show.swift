//
//  Show.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/6/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import Foundation

// MARK: - Show
struct Show: Codable {
    let id: Int
    let url: String
    let name, type, language: String
    let genres: [String]
    let status: String
    let runtime: Int
    let premiered: String
    let officialSite: String
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network: Network?
    let externals: Externals?
    let image: Image
    let summary: String?
    let updated: Int
    let links: APIShowLinks?
    let embedded: Embedded

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, premiered, officialSite, schedule, rating, weight, network, externals, image, summary, updated
        case links = "_links"
        case embedded = "_embedded"
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    let episodes: [Episode]
}

// MARK: - Episode
struct Episode: Codable {
    let id: Int
    let url: String?
    let name: String
    let season, number: Int
    let airdate: String?
    let airtime: String?
    let airstamp: String?
    let runtime: Int?
    let image: Image?
    let summary: String?
    let links: EpisodeLinks?

    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, airdate, airtime, airstamp, runtime, image, summary
        case links = "_links"
    }
}

// MARK: - EpisodeLinks
struct EpisodeLinks: Codable {
    let linksSelf: Previousepisode?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Previousepisode
struct Previousepisode: Codable {
    let href: String?
}


// MARK: - APIShowLinks
struct APIShowLinks: Codable {
    let linksSelf, previousepisode: Previousepisode?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode
    }
}


