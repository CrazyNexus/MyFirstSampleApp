//
// MyPrefixStockMasterTableDelegate.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//
import Foundation
import SAPFoundation
import SAPOData
import SAPCommon

class MyPrefixStockMasterTableDelegate: NSObject, MasterTableDelegate {
    private let dataAccess: MyPrefixMyServiceClassDataAccess!
    weak var errorDelegate: MasterTableErrorHandlerDelegate?
    private var _entities: [MyPrefixStock] = [MyPrefixStock]()
    private let logger: Logger = Logger.shared(named: "MasterTableDelegateLogger")
    var entities: [EntityValue] {
        get { return _entities }
        set { self._entities = newValue as! [MyPrefixStock]
        }
    }

    init(dataAccess: MyPrefixMyServiceClassDataAccess) {
        self.dataAccess = dataAccess
    }

    func requestEntities(completionHandler: @escaping(Error?) -> Void) {
        self.dataAccess.loadMyPrefixStock { (myprefixstock, error) in
            guard let myprefixstock = myprefixstock else {
                completionHandler(error!)
                return
            }
            self.entities = myprefixstock
            completionHandler(nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._entities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myprefixstock = self.entities[indexPath.row] as! MyPrefixStock
        let cell = cellWithNonEditableContent(tableView: tableView, indexPath: indexPath, key: "ProductId", value: "\(myprefixstock.productID ?? "")")
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let currentEntity = self.entities[indexPath.row] as? MyPrefixStock, editingStyle == .delete else {
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
