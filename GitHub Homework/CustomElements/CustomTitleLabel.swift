//
//  CustomTitleLabel.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/19/20.
//

import UIKit

class GHTitleLabel: UILabel {

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = .systemFont(ofSize: fontSize, weight: .bold)

        setupUI()
    }

    // MARK: - UI Setup

    fileprivate func setupUI() {
        textColor = .darkGray
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
