//
// MyPrefixProductsMasterTableDelegate.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//
import Foundation
import SAPFoundation
import SAPOData
import SAPCommon

class MyPrefixProductsMasterTableDelegate: NSObject, MasterTableDelegate {
    private let dataAccess: MyPrefixMyServiceClassDataAccess!
    weak var errorDelegate: MasterTableErrorHandlerDelegate?
    private var _entities: [MyPrefixProduct] = [MyPrefixProduct]()
    private let logger: Logger = Logger.shared(named: "MasterTableDelegateLogger")
    var entities: [EntityValue] {
        get { return _entities }
        set { self._entities = newValue as! [MyPrefixProduct]
        }
    }

    init(dataAccess: MyPrefixMyServiceClassDataAccess) {
        self.dataAccess = dataAccess
    }

    func requestEntities(completionHandler: @escaping(Error?) -> Void) {
        self.dataAccess.loadMyPrefixProducts { (myprefixproducts, error) in
            guard let myprefixproducts = myprefixproducts else {
                completionHandler(error!)
                return
            }
            self.entities = myprefixproducts
            completionHandler(nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._entities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myprefixproduct = self.entities[indexPath.row] as! MyPrefixProduct
        let cell = cellWithNonEditableContent(tableView: tableView, indexPath: indexPath, key: "ProductId", value: "\(myprefixproduct.productID ?? "")")
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        
        cell.headlineText = myprefixproduct.name
        cell.subheadlineText = myprefixproduct.productID
        cell.footnoteText = myprefixproduct.categoryName
        cell.descriptionText = myprefixproduct.longDescription
        print(myprefixproduct.pictureUrl ?? "no Information")
        cell.detailImage = UIImage(named: myprefixproduct.pictureUrl!)                                            // TODO: needs to implement later
        cell.detailImage?.accessibilityIdentifier = myprefixproduct.name
        cell.statusText = formatter.string(from: NSNumber(value: (myprefixproduct.price?.doubleValue())!))! + " " + myprefixproduct.currencyCode!
        cell.substatusText = "In Stock"
        cell.substatusLabel.textColor = UIColor.preferredFioriColor(forStyle: .positive)
        cell.splitPercent = CGFloat(0.3)
        cell.detailImageView.isCircular = true
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let currentEntity = self.entities[indexPath.row] as? MyPrefixProduct, editingStyle == .delete else {
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
