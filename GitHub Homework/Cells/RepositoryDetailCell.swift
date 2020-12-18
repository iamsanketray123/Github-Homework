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
    @IBOutlet weak var createdAt: UILabel!
    
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
        details.text = repository.description ?? "No description available for this repository"
        stars.text = "\(repository.stars)"
        license.text = repository.license?.name
        if repository.language == nil {
            circleView.isHidden = true
        } else {
            circleView.isHidden = false
        }
        language.text = repository.language
        createdAt.text = createdDateString(createdString: repository.createdAt)
    }
    
    fileprivate func createdDateString(createdString: String)-> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = formatter.date(from: createdString) else { return nil }
        formatter.dateFormat = "MMM d, yyyy"
        let dateString = formatter.string(from: date)
        return "Created: " + dateString
    }
}
