//
//  TVMazeService.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/5/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import Siesta

protocol BaseService {
    func getShows(_ search: String) -> Resource
    func getShowEpisodes(showId: String) -> Resource
}

final class TVMazeService: BaseService {
    
    struct Dependencies {
        let baseUrl: String! = "https://api.tvmaze.com"
        var service: Service!
        let decoder = JSONDecoder()
    }
    var dependencies: Dependencies
    
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
        self.configure()
    }
    
    private func configure() {
        #if DEBUG
        LogCategory.enabled = [.network]
        #endif
        dependencies.service = Service(baseURL: dependencies.baseUrl, standardTransformers: [.image, .text])
        
        // Process response data as a json in order to don't use Dictionaries
        dependencies.service.configureTransformer("/search/shows") {
            // Input type inferred because the from: param takes Data.
            // Output type inferred because jsonDecoder.decode() will return RedditObject
            try self.dependencies.decoder.decode(Shows.self, from: $0.content)
            
        }
        
        dependencies.service.configureTransformer("/shows/*") {
            // Input type inferred because the from: param takes Data.
            // Output type inferred because jsonDecoder.decode() will return RedditObject
            try self.dependencies.decoder.decode(Show.self, from: $0.content)
        }
    }
    
    func getShowEpisodes(showId: String) -> Resource {
        let path = "/shows/" + showId
        return dependencies.service.resource(path).withParam("embed", "episodes")
    }
    
    func getShows(_ search: String) -> Resource {
        let path = "/search/shows"
        return dependencies.service.resource(path).withParam("q", search)
    }
    
    deinit {
        dependencies.service = nil
    }
}
