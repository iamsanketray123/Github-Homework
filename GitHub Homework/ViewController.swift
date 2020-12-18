//
//  ViewController.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/18/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        
        
        
        
        
    }
    
    fileprivate func setupUI() {
        searchBar.delegate = self
    }


}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showLoadingView()
            NetworkManager.shared.fetchRepository(with: searchBar.text!) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case.success(let response):
                    print(response, "🦋")
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(SearchResultsController(), animated: true)
                        self.dismissLoadingView()
                    }
                    
                case .failure(let error):
                    print(error, "🐙")
                    switch error {
                    case .noResults:
                        self.presentGHAlertOnMainThread(title: "Error", message: "No results were found for the repository name. Please try again!", buttonTitle: "Ok")
                    default:
                        ()
                    }
                }
                
            }
        }
    }
}
