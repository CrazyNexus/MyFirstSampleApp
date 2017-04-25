//
// ActivityIndicator.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//

import Foundation
import UIKit

protocol ActivityIndicator {}

extension ActivityIndicator where Self: UIViewController {

    func initActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        // Helps to find the position of activity indicator on different landscapes
        activityIndicatorView.autoresizingMask = [.flexibleBottomMargin, .flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleWidth]
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.activityIndicatorViewStyle = .gray

        return activityIndicatorView
    }

    func showActivityIndicator(_ activityIndicatorView: UIActivityIndicatorView) {
        activityIndicatorView.startAnimating()
    }

    func hideActivityIndicator(_ activityIndicatorView: UIActivityIndicatorView) {
        activityIndicatorView.stopAnimating()
    }
}
