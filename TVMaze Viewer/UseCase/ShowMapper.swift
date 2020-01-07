//
//  ShowMapper.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/5/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import Foundation

final class ShowsMapper {
    func map(shows: [ShowElement]) -> [TVShow] {
        return shows.compactMap {
            return TVShow(id: $0.show.id, showName: $0.show.name, poster: $0.show.image?.secureImage, status: $0.show.status, schedule: $0.show.schedule, summary: $0.show.summary, genres: $0.show.genres)
        }
    }
}

final class ShowMapper {
    func fulfill(tvshow: inout TVShow, show: Show) {
        var lastSeason = 0
        tvshow.episodes = show.embedded.episodes.compactMap {
            lastSeason = lastSeason < $0.season ? $0.season : lastSeason
            return TVEpisode(id: $0.id, name: $0.name, season: $0.season, number: $0.number, image: $0.image?.secureImage, summary: $0.summary ?? "")
        }
        tvshow.numberOfSeasons = lastSeason
    }
}
