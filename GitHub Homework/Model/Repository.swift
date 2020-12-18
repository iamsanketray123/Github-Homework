//
//  Repository.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/18/20.
//

import Foundation

struct Repository {
    let name: String
    let stars: Int
    let createdAt: String
    let owner: Owner?
    let description: String?
    let language: String?
    let license: License?
    let lastUpdated: String?
}

struct Owner {
    let loginName: String
    let avatarString: String
}

struct License {
    let name: String
    let urlString: String?
}
