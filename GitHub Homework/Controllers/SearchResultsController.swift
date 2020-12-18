//
//  SearchResultsController.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/18/20.
//

import UIKit

class SearchResultsController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var repositories = [Repository]()
    let repositoryCellId = "repositoryCellId"
    let cellNibName = "RepositoryDetailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    fileprivate func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UINib.init(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: repositoryCellId)
        table.tableFooterView = UIView() // hide extra lines at bottom of tableView if there are no more elements to display
    }
}


extension SearchResultsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: repositoryCellId, for: indexPath) as! RepositoryDetailCell
        cell.repository = self.repositories[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.item]
        if let owner = repository.owner {
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
