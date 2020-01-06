//
//  ShowMapper.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/5/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import Foundation

final class ShowMapper {
    func map(shows: [ShowElement]) -> [TVShow] {
        return shows.compactMap {
            let image: String? = "https" + (String($0.show.image?.original.dropFirst(4) ?? ""))
            return TVShow(showName: $0.show.name, poster: image, status: $0.show.status, schedule: $0.show.schedule, summary: $0.show.summary)
        }
    }
}
