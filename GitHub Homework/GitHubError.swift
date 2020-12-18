//
//  GitHubError.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/18/20.
//

import Foundation

enum GHError: String, Error {
    case noResults = "No results were found for the repository name. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
