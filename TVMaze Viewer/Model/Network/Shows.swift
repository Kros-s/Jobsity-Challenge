//
//  Show.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/5/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import Foundation

// MARK: - ShowElement
struct ShowElement: Codable {
    let score: Double
    let show: ShowClass
}

// MARK: - ShowClass
struct ShowClass: Codable {
    let id: Int
    let url: String
    let name: String
    let type: String?
    let language: String
    let genres: [String]
    let status: String
    let runtime: Int?
    let premiered: String?
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network, webChannel: Network?
    let externals: Externals
    let image: Image?
    let summary: String
    let updated: Int
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, premiered, officialSite, schedule, rating, weight, network, webChannel, externals, image, summary, updated
        case links
    }
}

// MARK: - Externals
struct Externals: Codable {
    let tvrage, thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: Nextepisode
    let previousepisode, nextepisode: Nextepisode?

    enum CodingKeys: String, CodingKey {
        case linksSelf
        case previousepisode, nextepisode
    }
}

// MARK: - Nextepisode
struct Nextepisode: Codable {
    let href: String
}

// MARK: - Network
struct Network: Codable {
    let id: Int
    let name: String
    let country: Country?
}

// MARK: - Country
struct Country: Codable {
    let name, code, timezone: String
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String
    let days: [String]
}

typealias Shows = [ShowElement]
