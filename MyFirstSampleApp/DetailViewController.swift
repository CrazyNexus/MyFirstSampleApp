//
// DetailViewController.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//

import SAPFoundation
import SAPOData
import SAPFiori
import SAPCommon

class DetailViewController: UITableViewController, Notifier, ActivityIndicator {

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private var tableDelegate: DetailTableDelegate!
    private var activityIndicator: UIActivityIndicatorView!

    private let logger: Logger = Logger.shared(named: "DetailViewControllerLogger")
    var myPrefixMyServiceClass: MyPrefixMyServiceClassDataAccess {
        return appDelegate.myPrefixMyServiceClass
    }

    // The Entity which will be edited on the Detail View
    var selectedEntity: EntityValue!

    var collectionType: CollectionType = .none {
        didSet {
            if let delegate = self.generatedTableDelegate() {
                self.tableDelegate = delegate
                if self.selectedEntity != nil {
                    self.tableDelegate.entity = self.selectedEntity
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator = self.initActivityIndicator()
        self.activityIndicator.center = self.tableView.center
        self.tableView.addSubview(self.activityIndicator)

        self.tableView.allowsSelection = false
        self.tableView.dataSource = tableDelegate
        self.tableView.delegate = tableDelegate

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
    }

    @IBAction func updateEntity(_ sender: AnyObject) {
        self.showActivityIndicator(self.activityIndicator)
        DispatchQueue.global().async {

            self.logger.error("Dataservice online, updating entity in backend database.")
            do {
                try self.myPrefixMyServiceClass.service.updateEntity(self.tableDelegate.entity)
                DispatchQueue.main.async {
                    self.hideActivityIndicator(self.activityIndicator)
                    self.displayAlert(title: NSLocalizedString("keyUpdateEntityFinishedTitle", value: "Update entry finished", comment: "XTIT: Title of alert message about successful entity update."),
                        message: NSLocalizedString("keyUpdateEntityFinishedBody", value: "The operation was successful", comment: "XMSG: Body of alert message about successful entity update."),
                        buttonText: NSLocalizedString("keyOkButtonUpdateEntityFinished", value: "OK", comment: "XBUT: Title of OK button."))
                }
            } catch {
                DispatchQueue.main.async {
                    self.hideActivityIndicator(self.activityIndicator)
                    self.displayAlert(title: NSLocalizedString("keyErrorEntityUpdateTitle", value: "Update entry failed", comment: "XTIT: Title of alert message about entity update failure."),
                        message: NSLocalizedString("keyErrorEntityUpdateBody", value: "The operation was not successful.", comment: "XMSG: Body of alert message about entity update failure."),
                        buttonText: NSLocalizedString("keyOkButtonEntityUpdateError", value: "OK", comment: "XBUT: Title of OK button."))
                }
            }
        }
    }

    func createSelectedEntity() {
        self.showActivityIndicator(self.activityIndicator)
        DispatchQueue.global().async {
            do {

                self.logger.error("Dataservice online, creating entity in backend database.")
                try self.myPrefixMyServiceClass.service.createEntity(self.tableDelegate.entity)
                DispatchQueue.main.async {
                    self.hideActivityIndicator(self.activityIndicator)
                    self.displayAlert(title: NSLocalizedString("keyEntityCreationTitle", value: "Create entry finished", comment: "XTIT: Title of alert message about entity creation error."),
                        message: NSLocalizedString("keyEntityCreationBody", value: "The operation was successful", comment: "XMSG: Body of alert message about entity creation error."),
                        buttonText: NSLocalizedString("keyOkButtonEntityCreationFinished", value: "OK", comment: "XBUT: Title of OK button."))
                }
            } catch let error {
                DispatchQueue.main.async {

                    self.logger.error("Error happened in the creation process: \(error.localizedDescription)")
                    self.hideActivityIndicator(self.activityIndicator)
                    self.displayAlert(title: NSLocalizedString("keyErrorEntityCreationTitle", value: "Create entry failed", comment: "XTIT: Title of alert message about entity creation error."),
                        message: NSLocalizedString("keyErrorEntityCreationBody", value: "The operation was not successful", comment: "XMSG: Body of alert message about entity creation error."),
                        buttonText: NSLocalizedString("keyOkButtonEntityCreationError", value: "OK", comment: "XBUT: Title of OK button."))
                }
            }
        }
    }

    func cancel() -> Void {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
