//
// MyPrefixCustomersMasterTableDelegate.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//
import Foundation
import SAPFoundation
import SAPOData
import SAPCommon

class MyPrefixCustomersMasterTableDelegate: NSObject, MasterTableDelegate {
    private let dataAccess: MyPrefixMyServiceClassDataAccess!
    weak var errorDelegate: MasterTableErrorHandlerDelegate?
    private var _entities: [MyPrefixCustomer] = [MyPrefixCustomer]()
    private let logger: Logger = Logger.shared(named: "MasterTableDelegateLogger")
    var entities: [EntityValue] {
        get { return _entities }
        set { self._entities = newValue as! [MyPrefixCustomer]
        }
    }

    init(dataAccess: MyPrefixMyServiceClassDataAccess) {
        self.dataAccess = dataAccess
    }

    func requestEntities(completionHandler: @escaping(Error?) -> Void) {
        self.dataAccess.loadMyPrefixCustomers { (myprefixcustomers, error) in
            guard let myprefixcustomers = myprefixcustomers else {
                completionHandler(error!)
                return
            }
            self.entities = myprefixcustomers
            completionHandler(nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._entities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myprefixcustomer = self.entities[indexPath.row] as! MyPrefixCustomer
        let cell = cellWithNonEditableContent(tableView: tableView, indexPath: indexPath, key: "CustomerId", value: "\(myprefixcustomer.customerID ?? "")")
        // make a better use of FUIObjectTableViewCell
        cell.headlineText = (myprefixcustomer.firstName ?? "") + " " + (myprefixcustomer.lastName ?? "")
        cell.subheadlineText = myprefixcustomer.emailAddress ?? ""
        cell.footnoteText = myprefixcustomer.phoneNumber ?? ""
        cell.statusText = myprefixcustomer.customerID ?? ""
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let currentEntity = self.entities[indexPath.row] as? MyPrefixCustomer, editingStyle == .delete else {
            return
        }
        do {
            try self.dataAccess.service.deleteEntity(currentEntity)
            self.entities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        catch let error {

            self.logger.error("Delete entry failed: \(error.localizedDescription)")
            if let errorDelegate = self.errorDelegate {
                errorDelegate.errorDuringDelete(error: error) } }
    }
}
