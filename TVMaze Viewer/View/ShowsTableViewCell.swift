//
//  ShowsTableViewCell.swift
//  TVMaze Viewer
//
//  Created by Marco Antonio Mayen Hernandez on 1/5/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import UIKit
import Siesta

final class ShowsTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var leftIcon: RemoteImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subReddit: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title.adjustsFontSizeToFitWidth = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        configureStatus(isActive: highlighted)
    }

    
    /// Method to set the colors desired depenging state, could be use for selected too
    ///
    /// - Parameter isActive: flag to know if it's selected or even highlighted
    func configureStatus(isActive: Bool) {
        if isActive {
            view.layer.backgroundColor = UIColor.gray.cgColor
        } else {
            view.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
}

