//
//  RepositoryDetailCell.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/18/20.
//

import UIKit

final class RepositoryDetailCell: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var license: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var language: UILabel!
    
    var repository: Repository? = nil  {
        didSet {
            guard let repository = repository else { return }
            setupUI(for: repository)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    fileprivate func setupUI(for repository: Repository) {
        fullName.text = repository.name
        details.text = repository.description
        stars.text = "\(repository.stars)"
        license.text = repository.license?.name
        if repository.language == nil {
            circleView.isHidden = true
        } else {
            circleView.isHidden = false
        }
        language.text = repository.language
    }
    
}
