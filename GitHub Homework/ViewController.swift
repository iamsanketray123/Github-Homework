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
            NetworkManager.shared.fetchRepository(with: searchBar.text!) { [weak self] (result) in
                guard let _ = self else { return }
                
                switch result {
                case.success(let response):
                    print(response, "🦋")
                    
                case .failure(let error):
                    print(error, "🐙")
                }
                
            }
        }
    }
}
