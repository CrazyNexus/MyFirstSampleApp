//
// Constants.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//

import Foundation
import SAPFoundation

enum CollectionType: String {
    case myPrefixSalesOrderHeaders = "SalesOrderHeaders"
    case myPrefixProductTexts = "ProductTexts"
    case myPrefixSuppliers = "Suppliers"
    case myPrefixPurchaseOrderItems = "PurchaseOrderItems"
    case myPrefixStock = "Stock"
    case myPrefixCustomers = "Customers"
    case myPrefixProductCategories = "ProductCategories"
    case myPrefixSalesOrderItems = "SalesOrderItems"
    case myPrefixPurchaseOrderHeaders = "PurchaseOrderHeaders"
    case myPrefixProducts = "Products"
    case none = ""

    static let allValues: [CollectionType] = [
        myPrefixSalesOrderHeaders, myPrefixProductTexts, myPrefixSuppliers, myPrefixPurchaseOrderItems, myPrefixStock, myPrefixCustomers, myPrefixProductCategories, myPrefixSalesOrderItems, myPrefixPurchaseOrderHeaders, myPrefixProducts]
}

struct Constants {

    static let appId = "com.sap.OEA.MyFirstSampleApp"
    private static let sapcpmsUrlString = "https://mobile-d041630sapdev.int.sap.hana.ondemand.com/"
    static let sapcpmsUrl = URL(string: sapcpmsUrlString)!
    static let appUrl = Constants.sapcpmsUrl.appendingPathComponent(appId)
    static let configurationParameters = SAPcpmsSettingsParameters(backendURL: Constants.sapcpmsUrl, applicationID: Constants.appId)
}
