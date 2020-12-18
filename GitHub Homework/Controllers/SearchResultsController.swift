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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUI()
        
    }
    
    fileprivate func setupUI() {
//        self.navigationController?.navigationBar.topItem?.title = "Profile Settings"
    }

    
    fileprivate func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UINib.init(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: repositoryCellId)
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
}
