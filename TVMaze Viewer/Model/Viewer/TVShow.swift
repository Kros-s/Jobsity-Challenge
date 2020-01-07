//
//  TVShow.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/5/20.
//  Copyright © 2020 Kross. All rights reserved.
//
import Foundation

struct TVShow {
    let id: Int
    let showName: String
    let poster: String?
    let status: String
    let schedule: Schedule
    let summary: String
    let genres: [String]
    var generesDescription: String {
        genres.reduce("", { return $0 + " " + $1 })
    }
    var episodes: [TVEpisode] = []
    var numberOfSeasons: Int = 0
}
