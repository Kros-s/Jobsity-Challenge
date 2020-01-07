//
//  EpisodeViewController.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/6/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import UIKit
import Siesta

final class EpisodeViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genere: UILabel!
    var episode: TVEpisode!
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var poster: RemoteImageView!
    @IBOutlet weak var summary: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {

        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        poster.layer.borderWidth = 10.0
        poster.layer.masksToBounds = false
        poster.layer.borderColor = UIColor.white.cgColor
        poster.layer.cornerRadius = 100
        poster.clipsToBounds = true
        name.adjustsFontSizeToFitWidth = true
        poster.imageURL = episode.image
        name.text = episode.name
        summary.text = episode.summary.withoutHtmlTags
        episodeNumber.text = episode.number.description
        genere.text = episode.season.description
        
        
    }
    
    @IBAction func openSite(_ sender: Any) {
        guard let urlString = episode.image, urlString.isValidURL else { return }
        guard let url = URL(string: urlString) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func closePop(_ sender: Any) {
           self.dismiss(animated: true)
    }
}
