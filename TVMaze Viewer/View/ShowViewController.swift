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
    
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var poster: RemoteImageView!
    @IBOutlet weak var genere: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var numberOfSeasons: UILabel!
    
    var show: TVShow! //FIX THIS FORCE
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        setupView()
        showName.text = show.showName
        poster.imageURL = show.poster
        
        
    }
    
    func setupView() {
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
}

extension ShowViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
