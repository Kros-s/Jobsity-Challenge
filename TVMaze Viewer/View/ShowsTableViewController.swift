//
//  ViewController.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/5/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import UIKit
import Siesta

final class ShowsTableViewController: UITableViewController {
    
    lazy var presenter: ShowsPresenter = {
        ShowsPresenter(dependencies: .init(view: self))
    }()
    
    let expandableArea = ExpandableView()
    var leftConstraint: NSLayoutConstraint!
    let searchBar = UISearchBar()
    var selectedRow: Int = 0
    
    //Resource will populate this one always and trigger the update on the tableView
    var shows: [TVShow] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.searchMovies("Doctor")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTVShow", for: indexPath) as! ShowsTableViewCell

        let show = shows[indexPath.row] as TVShow
        cell.title.text = show.showName
        cell.subReddit.text = show.summary

        cell.leftIcon.imageURL = show.poster

        // FIXME: Move this to the init on the Cell
        //Setup for the view
        cell.leftIcon.layer.borderWidth = 1.0
        cell.leftIcon.layer.masksToBounds = false
        cell.leftIcon.layer.borderColor = UIColor.white.cgColor
        cell.leftIcon.layer.cornerRadius = 40
        cell.leftIcon.clipsToBounds = true
        return cell
    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedRow = indexPath.row
//        self.performSegue(withIdentifier: "s_preview", sender: nil)
//    }
//
//    /// Getting ready for the next view, here we sent the data to the next view
//    ///
//    /// - Parameters:
//    ///   - segue: segue being called
//    ///   - sender:
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "s_preview" {
//            let destinationVC = segue.destination as! PreviewViewController
//            destinationVC.view.backgroundColor = UIColor.clear
//            destinationVC.preview.imageURL = posts[selectedRow].thumbnail
//            destinationVC.posTtitle.text = posts[selectedRow].title
//            destinationVC.stringUrl = posts[selectedRow].url
//            destinationVC.renderPage()
//        }
//    }
    
}

extension ShowsTableViewController: ViewShowsDelegate {
    func update(shows: [TVShow]) {
        self.shows = shows
    }
}


extension ShowsTableViewController {

    /// Toggles constraint and hide/show tittle (expandableView) in order
    /// to create an animation for SearchBar
    @objc func toggle() {
        let isVisible = leftConstraint.isActive == true

        // Inactivating the left constraint closes the expandable header.
        leftConstraint.isActive = !isVisible

        // Animate change to visible.
        UIView.animate(withDuration: 1, animations: {
            self.navigationItem.titleView?.alpha =  !isVisible ? 1 : 0
            self.navigationItem.titleView?.layoutIfNeeded()
        })
    }

    /// Initializer for all setup necesary for the Post Screen
    func setupView() {

        navigationItem.titleView = expandableArea
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toggle))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        expandableArea.addSubview(searchBar)
        searchBar.placeholder = "Place the search here"
        searchBar.delegate = self

        //LeftConstraint
        leftConstraint = searchBar.leftAnchor.constraint(equalTo: expandableArea.leftAnchor)
        leftConstraint.isActive = false
        searchBar.rightAnchor.constraint(equalTo: expandableArea.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: expandableArea.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: expandableArea.bottomAnchor).isActive = true

    }
}



extension ShowsTableViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shows = []
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        shows = []
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shows = []
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        shows = []
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Ultra easy for update searchs, with the help of the observer in siesta
        if !searchText.isEmpty {
            presenter.searchMovies(searchText)
        } else {
            shows = []
        }

    }
}
