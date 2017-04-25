//
// MyPrefixPurchaseOrderItemDetailTableDelegate.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class MyPrefixPurchaseOrderItemDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: MyPrefixMyServiceClassDataAccess!
    private var _entity: MyPrefixPurchaseOrderItem?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? MyPrefixPurchaseOrderItem
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 9)

    init(dataAccess: MyPrefixMyServiceClassDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? MyPrefixPurchaseOrderItem else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if let currencyCode = currentEntity.currencyCode {
                value = "\(currencyCode)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderItem.currencyCode, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.currencyCode = nil
                    self.validity[0] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixPurchaseOrderItem.currencyCode) {
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
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderItem.grossAmount, value: value, changeHandler: { (newValue: String) -> Bool in
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
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderItem.netAmount, value: value, changeHandler: { (newValue: String) -> Bool in
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
            if let productID = currentEntity.productID {
                value = "\(productID)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderItem.productID, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.productID = nil
                    self.validity[3] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixPurchaseOrderItem.productID) {
                        currentEntity.productID = validValue
                        self.validity[3] = true
                    } else {
                        self.validity[3] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[3]
            })
        case 4:
            var value = ""
            value = currentEntity.itemNumber != nil ? "\(currentEntity.itemNumber!)" : ""
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderItem.itemNumber, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validInteger(from: newValue) {
                    currentEntity.itemNumber = validValue
                    self.validity[4] = true
                } else {
                    self.validity[4] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[4]
            })
        case 5:
            var value = ""
            value = "\(currentEntity.purchaseOrderID ?? "")"
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderItem.purchaseOrderID, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixPurchaseOrderItem.purchaseOrderID) {
                    currentEntity.purchaseOrderID = validValue
                    self.validity[5] = true
                } else {
                    self.validity[5] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[5]
            })
        case 6:
            var value = ""
            if let quantity = currentEntity.quantity {
                value = "\(quantity)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderItem.quantity, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.quantity = nil
                    self.validity[6] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.quantity = validValue
                        self.validity[6] = true
                    } else {
                        self.validity[6] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[6]
            })
        case 7:
            var value = ""
            if let quantityUnit = currentEntity.quantityUnit {
                value = "\(quantityUnit)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderItem.quantityUnit, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.quantityUnit = nil
                    self.validity[7] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixPurchaseOrderItem.quantityUnit) {
                        currentEntity.quantityUnit = validValue
                        self.validity[7] = true
                    } else {
                        self.validity[7] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[7]
            })
        case 8:
            var value = ""
            if let taxAmount = currentEntity.taxAmount {
                value = "\(taxAmount)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixPurchaseOrderItem.taxAmount, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.taxAmount = nil
                    self.validity[8] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.taxAmount = validValue
                        self.validity[8] = true
                    } else {
                        self.validity[8] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[8]
            })
        default:
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func createEntityWithDefaultValues() -> MyPrefixPurchaseOrderItem {
        let newEntity = MyPrefixPurchaseOrderItem()
        newEntity.itemNumber = defaultValueFor(MyPrefixPurchaseOrderItem.itemNumber)
        newEntity.purchaseOrderID = defaultValueFor(MyPrefixPurchaseOrderItem.purchaseOrderID)
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
