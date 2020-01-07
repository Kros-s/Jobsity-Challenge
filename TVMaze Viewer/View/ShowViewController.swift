//
//  ShowViewController.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/6/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import UIKit
import Siesta

final class ShowViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var poster: RemoteImageView!
    @IBOutlet weak var genere: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var numberOfSeasons: UILabel!
    
    var selectedPosition: IndexPath!
    
    var show: TVShow! //FIX THIS FORCE
    lazy var presenter: ShowPresenter = {
        return ShowPresenter(dependencies: .init(view: self))
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loader.startAnimating()
        presenter.getShowInfo(tvShow: show)
        setupView()
        showName.text = show.showName
        poster.imageURL = show.poster
        status.text = show.status
        genere.text = show.generesDescription
    }
    
    func setupView() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.episodePreview {
            let destinationVC = segue.destination as! EpisodeViewController
            let section = selectedPosition.section + 1
            let number = selectedPosition.row + 1
            let episode = show.episodes.first { $0.season == section && $0.number == number }
            destinationVC.episode = episode
            destinationVC.view.backgroundColor = UIColor.clear
        }
    }
}

extension ShowViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return show.numberOfSeasons
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = section + 1
        let numberOfEpisodesInSeason = show.episodes.filter { $0.season == section }.count
        return numberOfEpisodesInSeason
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = section + 1
        return "Season " + section.description
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifiers.episodeCell, for: indexPath) as! EpisodeTableViewCell
        let section = indexPath.section + 1
        let number = indexPath.row + 1
        let episode = show.episodes.first { $0.season == section && $0.number == number }
        cell.preview.imageURL = episode?.image
        cell.episodeName.text = "Name: " + (episode?.name ?? "Unknown")
        cell.numberOfEpisode.text = "Episode: " + (episode?.number.description ?? "---")
        cell.episodeSummary.text = episode?.summary.withoutHtmlTags ?? "Unknown"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPosition = indexPath
        self.performSegue(withIdentifier: Segues.episodePreview, sender: nil)
    }
    
    
}

extension ShowViewController: ViewShowDelegate {
    func update(show: TVShow) {
        self.show = show
        tableView.reloadData()
        numberOfSeasons.text = show.numberOfSeasons.description
        loader.stopAnimating()
    }
}
