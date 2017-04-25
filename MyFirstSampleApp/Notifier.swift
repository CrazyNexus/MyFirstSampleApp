//
// Notifier.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//

import UIKit

protocol Notifier {
    func displayAlert(title: String, message: String, buttonText: String)
}

extension Notifier where Self: UIViewController {

    func displayAlert(title: String, message: String, buttonText: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Create the actions
        let buttonAction = UIAlertAction(title: buttonText, style: UIAlertActionStyle.default) {
            UIAlertAction in
            alertController.dismiss(animated: true, completion: nil)
        }
        // Add the actions
        alertController.addAction(buttonAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}
