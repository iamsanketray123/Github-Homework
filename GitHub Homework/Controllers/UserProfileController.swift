//
//  UserProfileController.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/19/20.
//

import UIKit

class UserProfileController: UIViewController {
    
    @IBOutlet weak var loginName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var mapMarker: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var repos: UILabel!
    @IBOutlet weak var gist: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var memberSince: UILabel!
    @IBOutlet weak var bio: UILabel!
    
    var user: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - UI Setup
    
    fileprivate func setupUI() {
        guard let user = user else { return }
        
        loginName.text = user.login
        fullName.text = user.name
        location.text = user.location
        userImage.loadImageUsingCacheWithUrlString(user.avatarUrl, defaultImage: #imageLiteral(resourceName: "man"))
        user.location == nil ? (mapMarker.isHidden = true) : (mapMarker.isHidden = false)
        userImage.layer.cornerRadius = 16
        userImage.clipsToBounds = true
        repos.text = "\(user.publicRepos)"
        gist.text = "\(user.publicGists)"
        following.text = "\(user.following)"
        followers.text = "\(user.followers)"
        bio.text = user.bio
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = formatter.date(from: user.createdAt) else { return }
        formatter.dateFormat = "MMM, yyyy"
        let dateString = formatter.string(from: date)
        memberSince.text = "Member since: " + dateString
    }
    

}
