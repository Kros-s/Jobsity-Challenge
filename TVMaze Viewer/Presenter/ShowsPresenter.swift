//
//  ShowsPresenter.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/5/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import Siesta

protocol ViewShowsDelegate: class {
    func update(shows: [TVShow])
}

final class ShowsPresenter {
    
    struct Dependencies {
        var service: BaseService = TVMazeService()
        var mapper = ShowMapper()
        weak var view: ViewShowsDelegate?
        init(view: ViewShowsDelegate) {
            self.view = view
        }
    }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func searchMovies(_ query: String ) {
        dependencies.service.getShows(query).addObserver(self)
        .loadIfNeeded()
    }
}

extension ShowsPresenter: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        print(resource.latestError)
        guard let response: [ShowElement] = resource.typedContent() else {
            return
        }
        let mappedResponse = dependencies.mapper.map(shows: response)
        dependencies.view?.update(shows: mappedResponse)
    }
}
