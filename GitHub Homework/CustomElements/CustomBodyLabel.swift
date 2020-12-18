//
//  CustomLabel.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/19/20.
//

import UIKit

class GHBodyLabel: UILabel {

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment

        setupUI()
    }

    // MARK: - UI Setup

    fileprivate func setupUI() {
        textColor = .gray
        font = .preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

