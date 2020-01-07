//
//  ShowPresenter.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/6/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import Siesta

protocol ViewShowDelegate: class {
    func update(show: TVShow)
}

final class ShowPresenter {
    struct Dependencies {
        var service: BaseService = TVMazeService()
        var mapper = ShowMapper()
        weak var view: ViewShowDelegate?
        init(view: ViewShowDelegate) {
            self.view = view
        }
    }
    
    var currentTVShow: TVShow!
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getShowInfo(tvShow: TVShow) {
        currentTVShow = tvShow
        dependencies.service.getShowEpisodes(showId: tvShow.id.description).addObserver(self).loadIfNeeded()
    }
}

extension ShowPresenter: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        print(resource.latestError)
        guard let response: Show = resource.typedContent() else {
            return
        }
        dependencies.mapper.fulfill(tvshow: &currentTVShow, show: response)
        dependencies.view?.update(show: currentTVShow)
    }
}
