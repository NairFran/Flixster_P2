//
//  DetailViewController.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/5/22.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    
    var track: Track!

    override func viewDidLoad() {
        super.viewDidLoad()

        let poster_path = "https://image.tmdb.org/t/p/w500/\(track.poster_path)"
        Nuke.loadImage(with: URL(string: poster_path)!, into: trackImageView)
        
        trackNameLabel.text = track.original_title
        artistLabel.text = track.overview
        albumLabel.text = String(track.vote_count)
        genreLabel.text = String(track.vote_average)
        releaseDateLabel.text = track.release_date
        durationLabel.text = String(track.popularity)
    }
    
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        if let tappedView = sender.view {
            performSegue(withIdentifier: "evenMoreSegue", sender: tappedView)
        }
    }
    
}
