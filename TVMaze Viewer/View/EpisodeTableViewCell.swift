//
//  EpisodeTableViewCell.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/6/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import UIKit
import Siesta

final class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var numberOfEpisode: UILabel!
    @IBOutlet weak var preview: RemoteImageView!
    @IBOutlet weak var episodeSummary: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        configureStatus(isActive: highlighted)
    }
    
    func configureStatus(isActive: Bool) {
        if !isActive {
            self.contentView.backgroundColor = .white
            
        } else {
            self.contentView.backgroundColor = .blue
        }
    }

}
