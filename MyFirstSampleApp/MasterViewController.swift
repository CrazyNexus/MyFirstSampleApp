//
// MasterViewController.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//

import SAPOData
import SAPFoundation
import SAPFiori
import SAPCommon

class MasterViewController: UITableViewController, MasterTableErrorHandlerDelegate, Notifier, ActivityIndicator {

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var tableDelegate: MasterTableDelegate!
    private var activityIndicator: UIActivityIndicatorView!

    var collectionType: CollectionType = .none {
        didSet {
            self.configureView()
        }
    }

    private let logger: Logger = Logger.shared(named: "MasterViewControllerLogger")
    var myPrefixMyServiceClass: MyPrefixMyServiceClassDataAccess {
        return appDelegate.myPrefixMyServiceClass
    }

    func refresh() {
        DispatchQueue.global().async {
            self.updateTable(completionHandler: {
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize activity indicator
        self.activityIndicator = self.initActivityIndicator()
        self.activityIndicator.center = self.tableView.center
        self.tableView.addSubview(self.activityIndicator)
        // add refreshcontrol UI
        self.refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!)

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 98
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        FUIToastMessage.show(message: "Das ist ein Tost", icon: UIImage(named: "scrat")!, inView: self.view, withDuration: 1.5, maxNumberOfLines: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            // Show the selected Entity on the Detail view
            if let indexPath = self.tableView.indexPathForSelectedRow {

                self.logger.info("Showing details of the chosen element.")
                let selectedEntity = self.tableDelegate.entities[indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.selectedEntity = selectedEntity
                detailViewController.collectionType = self.collectionType
                detailViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if (segue.identifier == "addEntity") {
            if (self.collectionType != .none) {
                // Show the Detail view with a new Entity, which can be filled to create on the server

                self.logger.info("Showing view to add new entity.")
                let dest = segue.destination as! UINavigationController
                let detailController = dest.viewControllers[0] as! DetailViewController
                detailController.title = NSLocalizedString("keyAddEntityTitle", value: "Add Entity", comment: "XTIT: Title of add new entity screen.")
                let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: detailController, action: #selector(detailController.createSelectedEntity))
                detailController.navigationItem.rightBarButtonItem = doneButton
                let cancelButton = UIBarButtonItem(title: NSLocalizedString("keyCancelButtonToGoPreviousScreen", value: "Cancel", comment: "XBUT: Title of Cancel button."),
                    style: .plain, target: detailController, action: #selector(detailController.cancel))
                detailController.navigationItem.leftBarButtonItem = cancelButton
                detailController.collectionType = self.collectionType
                detailController.showDetailViewController(detailController, sender: sender)
            } else {
                self.displayAlert(title: NSLocalizedString("keyErrorEntityCreationTitle", value: "Entity creation error", comment: "XTIT: Title of alert message about entity creation error."),
                    message: NSLocalizedString("keyErrorEntityCreationBody", value: "Please select the proper collection to create an entity.", comment: "XMSG: Body of alert message about entity creation error."),
                    buttonText: NSLocalizedString("keyOkButtonEntityCreationError", value: "OK", comment: "XBUT: Title of OK button."))
            }
        }
    }

    private func configureView() {
        if self.collectionType != .none {
            self.title = collectionType.rawValue
            if let tableDelegate = self.generatedTableDelegate() {
                self.tableDelegate = tableDelegate
                if let tableView = self.tableView {
                    self.tableDelegate.errorDelegate = self
                    tableView.delegate = tableDelegate
                    tableView.dataSource = tableDelegate
                    self.updateTableWithActivityIndicator()
                }
            }
        }
    }

    // Fill the MasterView's list with Entity Identifiers
    private func updateTableWithActivityIndicator() {
        self.showActivityIndicator(self.activityIndicator)
        DispatchQueue.global().async {
            self.updateTable(completionHandler: {
                DispatchQueue.main.async {
                    self.hideActivityIndicator(self.activityIndicator)
                }
            })
        }
    }

    private func updateTable(completionHandler: @escaping() -> Void) {

        self.tableDelegate?.requestEntities { (error) in

            defer {
                completionHandler()
            }

            guard let error = error else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()

                    self.logger.info("Table updated successfully!")
                }
                return
            }
            self.displayAlert(title: NSLocalizedString("keyErrorLoadingData", value: "Loading data failed!", comment: "XTIT: Title of loading data error pop up."),
                message: "\(error.localizedDescription)",
                buttonText: NSLocalizedString("keyOkButtonLoadingDataError", value: "OK", comment: "XBUT: Title of OK button."))

            self.logger.error("Could not update table: \(error.localizedDescription)")
        }
    }

    func errorDuringDelete(error: Error) {
        self.displayAlert(title: NSLocalizedString("keyErrorDeletingEntryTitle", value: "Delete entry failed", comment: "XTIT: Title of deleting entry error pop up."),
            message: NSLocalizedString("keyErrorDeletingEntryBody", value: "The operation was unsuccessful.", comment: "XMSG: Body of deleting entry error pop up.") + "(\(error.localizedDescription))",
            buttonText: NSLocalizedString("keyOkButtonDeletingEntryError", value: "OK", comment: "XBUT: Title of OK button."))
    }
}
