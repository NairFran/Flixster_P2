//
//  TrackCell.swift
//  lab-tunley
//
//  Created by Walter Franchino on 2/5/23.
//

import UIKit
import Nuke

class TrackCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with track: Track) {
        trackNameLabel.text = track.original_title
        artistNameLabel.text = track.overview

        let poster_path = "https://image.tmdb.org/t/p/w500/\(track.poster_path)"
        Nuke.loadImage(with: URL(string: poster_path)!, into: trackImageView)
        
    }
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    
}
