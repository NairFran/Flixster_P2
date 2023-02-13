//
//  ViewController.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/1/22.
//

import UIKit

class TracksViewController: UIViewController, UITableViewDataSource {
    var tracks: [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=74c5c7b3aa58b97665ab0e2531db6044&language=en-US&page=1")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("❌ Network error: \(error)")
            }
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let response = try decoder.decode(TracksResponse.self, from: data)
                let tracks = response.results
                
                DispatchQueue.main.async {

                    // Set the view controller's tracks property as this is the one the table view references
                    self?.tracks = tracks

                    // Make the table view reload now that we have new data
                    self?.tableView.reloadData()
                }
            } catch {
                print("❌ Error parsing JSON: \(error)")
            }
        }
        task.resume()
        print("👋 Below the closure")
        print(tracks)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        let track = tracks[indexPath.row]
        cell.configure(with: track)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let detailViewController = segue.destination as? DetailViewController {
            let track = tracks[indexPath.row]
            detailViewController.track = track
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
}
