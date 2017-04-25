//
// MyPrefixPurchaseOrderHeaderDetailTableDelegate.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class MyPrefixPurchaseOrderHeaderDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: MyPrefixMyServiceClassDataAccess!
    private var _entity: MyPrefixPurchaseOrderHeader?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? MyPrefixPurchaseOrderHeader
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 6)

    init(dataAccess: MyPrefixMyServiceClassDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? MyPrefixPurchaseOrderHeader else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if let currencyCode = currentEntity.currencyCode {
                value = "\(currencyCode)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderHeader.currencyCode, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.currencyCode = nil
                    self.validity[0] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixPurchaseOrderHeader.currencyCode) {
                        currentEntity.currencyCode = validValue
                        self.validity[0] = true
                    } else {
                        self.validity[0] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[0]
            })
        case 1:
            var value = ""
            if let grossAmount = currentEntity.grossAmount {
                value = "\(grossAmount)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderHeader.grossAmount, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.grossAmount = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.grossAmount = validValue
                        self.validity[1] = true
                    } else {
                        self.validity[1] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[1]
            })
        case 2:
            var value = ""
            if let netAmount = currentEntity.netAmount {
                value = "\(netAmount)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderHeader.netAmount, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.netAmount = nil
                    self.validity[2] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.netAmount = validValue
                        self.validity[2] = true
                    } else {
                        self.validity[2] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[2]
            })
        case 3:
            var value = ""
            value = "\(currentEntity.purchaseOrderID ?? "")"
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderHeader.purchaseOrderID, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixPurchaseOrderHeader.purchaseOrderID) {
                    currentEntity.purchaseOrderID = validValue
                    self.validity[3] = true
                } else {
                    self.validity[3] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[3]
            })
        case 4:
            var value = ""
            if let supplierID = currentEntity.supplierID {
                value = "\(supplierID)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderHeader.supplierID, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.supplierID = nil
                    self.validity[4] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixPurchaseOrderHeader.supplierID) {
                        currentEntity.supplierID = validValue
                        self.validity[4] = true
                    } else {
                        self.validity[4] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[4]
            })
        case 5:
            var value = ""
            if let taxAmount = currentEntity.taxAmount {
                value = "\(taxAmount)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderHeader.taxAmount, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.taxAmount = nil
                    self.validity[5] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.taxAmount = validValue
                        self.validity[5] = true
                    } else {
                        self.validity[5] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[5]
            })
        default:
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func createEntityWithDefaultValues() -> MyPrefixPurchaseOrderHeader {
        let newEntity = MyPrefixPurchaseOrderHeader()
        newEntity.purchaseOrderID = defaultValueFor(MyPrefixPurchaseOrderHeader.purchaseOrderID)
        return newEntity
    }

    // Check if all text fields are valid
    private func barButtonShouldBeEnabled() {
        let anyFieldInvalid = self.validity.first { (field) -> Bool in
            return field == false
        }
        self.rightBarButton.isEnabled = anyFieldInvalid == nil
    }
}
