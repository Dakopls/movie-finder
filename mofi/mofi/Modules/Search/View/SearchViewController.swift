//
//  SearchViewController.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 01/12/2021.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchViewProtocol {

    // MARK: - Properties
    var presenter: SearchPresenterProtocol?
    private var movies = [MovieEntity]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //No additional init needed
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSettings()
        searchBarSettings()
    }
    
    // MARK: - Setups
    func searchBarSettings() {
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.placeholder = "Type a title or theme..."
        self.searchBar.layer.cornerRadius = 8.0
    }
    
    func tableSettings() {
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        self.tableView.allowsSelection = true
        self.tableView.rowHeight = 292
        self.tableView.separatorStyle = .none
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var sections = 0
        if self.movies.count > 0 {
            sections = 1
            self.tableView.backgroundView = nil
        }
        else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No recent searches"
            noDataLabel.textColor = UIColor.lightGray
            noDataLabel.textAlignment = .center
            self.tableView.backgroundView = noDataLabel
        }
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let movie = self.movies[indexPath.row]
//        cell.photo?.kf.setImage(with: URL(string: room.photos[0].url_small!))
        cell.title?.text = movie.title
        cell.year?.text = movie.year
        cell.type?.text = movie.type.rawValue
        cell.contentView.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) != nil else { return }
        self.presenter?.perform(action: .itemSelected(index: indexPath.row))
    }
    
    // MARK: - RoomsViewProtocol
    func populate(_ state: SearchState) {
        switch state {
        case .success(let entity):
            self.movies = entity
            self.tableView.reloadData()
        case .error(let error):
            print(error) //TBD
        }
    }
}

// MARK: - Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 4 { return }
        self.presenter?.perform(action: .textEntered(text: searchText))
    }
}

