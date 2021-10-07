//
//  UIViewController+ActivityIndicator.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 07.10.2021.
//

import UIKit

extension UITableViewController {

    func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        let style: UIActivityIndicatorView.Style
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                style = .white
            } else {
                style = .gray
            }
        } else {
            style = .gray
        }

        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: size)

        return activityIndicator
    }
}
