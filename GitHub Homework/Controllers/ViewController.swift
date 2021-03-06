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
    let reachability = Reachability()!
    var trendingRepos = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchTrendingRepos()
        setupConnectivityNotifier()
    }
    
    // MARK: - UI Setup
    
    fileprivate func setupUI() {
        
        searchBar.delegate = self
        table.delegate = self
        table.dataSource = self
        table.register(UINib.init(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: repositoryCellId)
        table.keyboardDismissMode = .onDrag
        table.tableFooterView = UIView()
    }
    
    // MARK: - Make API call to fetch required results
    
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
                    self.presentGHAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "OK")
                    self.dismissLoadingView()
                }
            }
        }
    }
    
    // MARK: - Check if we have internet
    
    fileprivate func setupConnectivityNotifier() {
        NotificationCenter.default.addObserver(self, selector: #selector(internetConnectionChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start notifier")
        }
    }
    
    @objc func internetConnectionChanged(notification : Notification) {
        let reachability = notification.object as! Reachability
        if reachability.connection == .none {
            presentGHAlertOnMainThread(title: "No Internet", message: "Please check your internet connectivity and try again!", buttonTitle: "OK")
        }
//        MARK: Need to fix --> leading to a bug
        
//        else {
//            if trendingRepos.isEmpty {
//                fetchTrendingRepos()
//            }
//        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = trendingRepos[indexPath.item]
        if let owner = repo.owner {
            showLoadingView()
            NetworkManager.shared.getUserInfo(for: owner.loginName) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case.success(let user):
                    DispatchQueue.main.async {
                        let userProfileController = UserProfileController()
                        userProfileController.user = user
                        self.navigationController?.pushViewController(userProfileController, animated: true)
                        self.dismissLoadingView()
                    }
                case .failure(let error):
                    self.presentGHAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "OK")
                    self.dismissLoadingView()
                }
            }
        }
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
