//
//  Albums2ViewController.swift
//  lab-tunley
//
//  Created by Walter Franchino on 2/12/23.
//

import UIKit
import Nuke

class Albums2ViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCell

            // Use the indexPath.item to index into the albums array to get the corresponding album
            let album = albums[indexPath.item]

            let poster_path = "https://image.tmdb.org/t/p/w500/\(album.poster_path)"
        Nuke.loadImage(with: URL(string: poster_path)!, into: cell.albumImageView)

            return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/758009/similar?api_key=74c5c7b3aa58b97665ab0e2531db6044&language=en-US&page=1")!
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error)")
            }
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(AlbumSearchResponse.self, from: data)
                let albums = response.results
                self?.albums = albums
                DispatchQueue.main.async {
                    self?.albums = albums
                    self?.collectionView.reloadData()
                }
                print(albums)
            } catch {
                print(error)
            }
            
        }

        // Initiate the network request
        task.resume()
        // Get a reference to the collection view's layout
        // We want to dynamically size the cells for the available space and desired number of columns.
        // NOTE: This collection view scrolls vertically, but collection views can alternatively scroll horizontally.
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumInteritemSpacing = 0

        // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumLineSpacing = 2

        // Set this to however many columns you want to show in the collection.
        let numberOfColumns: CGFloat = 3

        // Calculate the width each cell need to be to fit the number of columns, taking into account the spacing between cells.
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns

        // Set the size that each tem/cell should display at
        layout.itemSize = CGSize(width: width, height: width)
    }
    var albums: [Album] = []

    
    @IBOutlet weak var collectionView: UICollectionView!
}
