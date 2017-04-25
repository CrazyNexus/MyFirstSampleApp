//
// MyPrefixProductTextDetailTableDelegate.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class MyPrefixProductTextDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: MyPrefixMyServiceClassDataAccess!
    private var _entity: MyPrefixProductText?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? MyPrefixProductText
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 6)

    init(dataAccess: MyPrefixMyServiceClassDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? MyPrefixProductText else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            value = currentEntity.id != nil ? "\(currentEntity.id!)" : ""
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixProductText.id, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validInt64(from: newValue) {
                    currentEntity.id = validValue
                    self.validity[0] = true
                } else {
                    self.validity[0] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[0]
            })
        case 1:
            var value = ""
            if let language = currentEntity.language {
                value = "\(language)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixProductText.language, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.language = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixProductText.language) {
                        currentEntity.language = validValue
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
            if let longDescription = currentEntity.longDescription {
                value = "\(longDescription)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixProductText.longDescription, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.longDescription = nil
                    self.validity[2] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixProductText.longDescription) {
                        currentEntity.longDescription = validValue
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
            if let name = currentEntity.name {
                value = "\(name)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixProductText.name, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.name = nil
                    self.validity[3] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixProductText.name) {
                        currentEntity.name = validValue
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
            if let productID = currentEntity.productID {
                value = "\(productID)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixProductText.productID, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.productID = nil
                    self.validity[4] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixProductText.productID) {
                        currentEntity.productID = validValue
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
            if let shortDescription = currentEntity.shortDescription {
                value = "\(shortDescription)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixProductText.shortDescription, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.shortDescription = nil
                    self.validity[5] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixProductText.shortDescription) {
                        currentEntity.shortDescription = validValue
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

    func createEntityWithDefaultValues() -> MyPrefixProductText {
        let newEntity = MyPrefixProductText()
        newEntity.id = defaultValueFor(MyPrefixProductText.id)
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
