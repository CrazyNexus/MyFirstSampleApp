//
// MyPrefixCustomerDetailTableDelegate.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class MyPrefixCustomerDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: MyPrefixMyServiceClassDataAccess!
    private var _entity: MyPrefixCustomer?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? MyPrefixCustomer
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 12)

    init(dataAccess: MyPrefixMyServiceClassDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? MyPrefixCustomer else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if let city = currentEntity.city {
                value = "\(city)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.city, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.city = nil
                    self.validity[0] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixCustomer.city) {
                        currentEntity.city = validValue
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
            if let country = currentEntity.country {
                value = "\(country)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.country, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.country = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixCustomer.country) {
                        currentEntity.country = validValue
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
            value = "\(currentEntity.customerID ?? "")"
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.customerID, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixCustomer.customerID) {
                    currentEntity.customerID = validValue
                    self.validity[2] = true
                } else {
                    self.validity[2] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[2]
            })
        case 3:
            var value = ""
            value = currentEntity.dateOfBirth != nil ? "\(currentEntity.dateOfBirth!)" : ""
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.dateOfBirth, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validLocalDateTime(from: newValue) { // This is just a simple solution to handle UTC only
                    currentEntity.dateOfBirth = validValue
                    self.validity[3] = true
                } else {
                    self.validity[3] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[3]
            })
        case 4:
            var value = ""
            if let emailAddress = currentEntity.emailAddress {
                value = "\(emailAddress)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.emailAddress, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.emailAddress = nil
                    self.validity[4] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixCustomer.emailAddress) {
                        currentEntity.emailAddress = validValue
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
            if let firstName = currentEntity.firstName {
                value = "\(firstName)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.firstName, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.firstName = nil
                    self.validity[5] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixCustomer.firstName) {
                        currentEntity.firstName = validValue
                        self.validity[5] = true
                    } else {
                        self.validity[5] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[5]
            })
        case 6:
            var value = ""
            if let houseNumber = currentEntity.houseNumber {
                value = "\(houseNumber)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.houseNumber, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.houseNumber = nil
                    self.validity[6] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixCustomer.houseNumber) {
                        currentEntity.houseNumber = validValue
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
            if let lastName = currentEntity.lastName {
                value = "\(lastName)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.lastName, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.lastName = nil
                    self.validity[7] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixCustomer.lastName) {
                        currentEntity.lastName = validValue
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
            if let phoneNumber = currentEntity.phoneNumber {
                value = "\(phoneNumber)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.phoneNumber, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.phoneNumber = nil
                    self.validity[8] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixCustomer.phoneNumber) {
                        currentEntity.phoneNumber = validValue
                        self.validity[8] = true
                    } else {
                        self.validity[8] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[8]
            })
        case 9:
            var value = ""
            if let postalCode = currentEntity.postalCode {
                value = "\(postalCode)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.postalCode, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.postalCode = nil
                    self.validity[9] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixCustomer.postalCode) {
                        currentEntity.postalCode = validValue
                        self.validity[9] = true
                    } else {
                        self.validity[9] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[9]
            })
        case 10:
            var value = ""
            if let street = currentEntity.street {
                value = "\(street)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.street, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.street = nil
                    self.validity[10] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: MyPrefixCustomer.street) {
                        currentEntity.street = validValue
                        self.validity[10] = true
                    } else {
                        self.validity[10] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[10]
            })
        case 11:
            var value = ""
            if let updatedTimestamp = currentEntity.updatedTimestamp {
                value = "\(updatedTimestamp)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: MyPrefixCustomer.updatedTimestamp, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.updatedTimestamp = nil
                    self.validity[11] = true
                } else {
                    if let validValue = TypeValidator.validLocalDateTime(from: newValue) { // This is just a simple solution to handle UTC only
                        currentEntity.updatedTimestamp = validValue
                        self.validity[11] = true
                    } else {
                        self.validity[11] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[11]
            })
        default:
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func createEntityWithDefaultValues() -> MyPrefixCustomer {
        let newEntity = MyPrefixCustomer()
        newEntity.customerID = defaultValueFor(MyPrefixCustomer.customerID)
        newEntity.dateOfBirth = defaultValueFor(MyPrefixCustomer.dateOfBirth)
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
