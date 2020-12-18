//
//  SearchResultsController.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/18/20.
//

import UIKit

class SearchResultsController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
//        self.navigationController?.navigationBar.topItem?.title = "Profile Settings"
        self.navigationController?.title = "Hello"
        print(self.navigationController, "🦋")
    }

    

}
