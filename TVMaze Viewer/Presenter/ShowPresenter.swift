//
//  ShowPresenter.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/6/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import Siesta

protocol ViewShowDelegate: class {
    
}

final class ShowPresenter {
    struct Dependencies {
        var service: BaseService = TVMazeService()
        weak var view: ViewShowsDelegate?
        init(view: ViewShowsDelegate) {
            self.view = view
        }
    }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getShowInfo(tvShowId: String) {
        dependencies.service.getShowEpisodes(showId: tvShowId).addObserver(self).loadIfNeeded()
    }
}

extension ShowPresenter: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        print(resource.latestError)
//        guard let response: [ShowElement] = resource.typedContent() else {
//            return
//        }
//        let mappedResponse = dependencies.mapper.map(shows: response)
//        dependencies.view?.update(shows: mappedResponse)
    }
}
