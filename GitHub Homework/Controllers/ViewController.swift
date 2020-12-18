//
//  ViewController.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/18/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var table: UITableView!
    
    let repositoryCellId = "repositoryCellId"
    let cellNibName = "RepositoryDetailCell"
    
    var trendingRepos = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchTrendingRepos()
    }
    
    fileprivate func setupUI() {
        
        searchBar.delegate = self
        table.delegate = self
        table.dataSource = self
        table.register(UINib.init(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: repositoryCellId)
        table.keyboardDismissMode = .onDrag
    }
    
    fileprivate func fetchTrendingRepos() {
        showLoadingView()
        NetworkManager.shared.fetchRepository(shouldFetchPopularSwiftRepos: true) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case.success(let repos):
                DispatchQueue.main.async {
                    self.trendingRepos = repos
                    self.table.reloadData()
                    self.dismissLoadingView()
                }
                
            case .failure(let error):
                switch error {
                case .noResults:
                    self.dismissLoadingView()
                    self.presentGHAlertOnMainThread(title: "Error", message: "No results were found for the repository name. Please try again!", buttonTitle: "Ok")
                default:
                    ()
                }
            }
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: repositoryCellId, for: indexPath) as! RepositoryDetailCell
        cell.repository = trendingRepos[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, text.count > 0 else {
            presentGHAlertOnMainThread(title: "Empty Seacrh", message: "Please enter a repository name to search for.", buttonTitle: "OK")
            return
        }
        
        showLoadingView()
        NetworkManager.shared.fetchRepository(with: text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case.success(let repositories):
                DispatchQueue.main.async {
                    let searchResultsController = SearchResultsController()
                    searchResultsController.repositories = repositories
                    self.navigationController?.pushViewController(searchResultsController, animated: true)
                    self.dismissLoadingView()
                }
                
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "OK")
                self.dismissLoadingView()
            }
            
        }
        
    }
}
