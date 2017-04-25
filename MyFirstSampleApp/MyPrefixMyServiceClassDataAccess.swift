//
// MyPrefixMyServiceClassDataAccess.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//
import Foundation
import SAPCommon
import SAPFoundation
import SAPOData
import SAPOfflineOData

class MyPrefixMyServiceClassDataAccess {
    var service: MyPrefixMyServiceClass<OnlineODataProvider>
    var offlineService: MyPrefixMyServiceClass<OfflineODataProvider>
    var storeOpend = false
    
    private let logger: Logger = Logger.shared(named: "ServiceDataAccessLogger")

    init(urlSession: SAPURLSession) {
        let odataProvider = OnlineODataProvider(serviceName: "myServiceName", serviceRoot: Constants.appUrl, sapURLSession: urlSession)
        odataProvider.serviceOptions.checkVersion = false // this disables version validation of the backend OData service and should only be used in demo and test applications
        odataProvider.traceRequests = true
        odataProvider.traceWithData = true
        odataProvider.prettyTracing = true
        
        self.service = MyPrefixMyServiceClass(provider: odataProvider)
        // To update entity force to use X-HTTP-Method header
        _ = self.service.provider.networkOptions.tunneledMethods.append("MERGE")
        
        let offlineParameters = OfflineODataParameters()
        //offlineParameters.customHeaders = ["X-SMP-APPID": Constants.appId]
        let offlineODataProvider = try! OfflineODataProvider(serviceRoot: Constants.appUrl, parameters: offlineParameters, sapURLSession: urlSession)
        try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: CollectionType.myPrefixCustomers.rawValue, query: "/\(CollectionType.myPrefixCustomers.rawValue)?Stop=20", automaticallyRetrievesStreams: false))
        self.offlineService = MyPrefixMyServiceClass(provider: offlineODataProvider)
    }

    // -------DataRequesterForEntity: SalesOrderHeaders -------
    func loadMyPrefixSalesOrderHeaders(completionHandler: @escaping([MyPrefixSalesOrderHeader]?, Error?) -> Void) {
        self.executeRequest(self.service.salesOrderHeaders, completionHandler: completionHandler)
    }

    // -------DataRequesterForEntity: ProductTexts -------
    func loadMyPrefixProductTexts(completionHandler: @escaping([MyPrefixProductText]?, Error?) -> Void) {
        self.executeRequest(self.service.productTexts, completionHandler: completionHandler)
    }

    // -------DataRequesterForEntity: Suppliers -------
    func loadMyPrefixSuppliers(completionHandler: @escaping([MyPrefixSupplier]?, Error?) -> Void) {
        self.executeRequest(self.service.suppliers, completionHandler: completionHandler)
    }

    // -------DataRequesterForEntity: PurchaseOrderItems -------
    func loadMyPrefixPurchaseOrderItems(completionHandler: @escaping([MyPrefixPurchaseOrderItem]?, Error?) -> Void) {
        self.executeRequest(self.service.purchaseOrderItems, completionHandler: completionHandler)
    }

    // -------DataRequesterForEntity: Stock -------
    func loadMyPrefixStock(completionHandler: @escaping([MyPrefixStock]?, Error?) -> Void) {
        self.executeRequest(self.service.stock, completionHandler: completionHandler)
    }

    // -------DataRequesterForEntity: Customers -------
    func loadMyPrefixCustomers(completionHandler: @escaping([MyPrefixCustomer]?, Error?) -> Void) {
        self.executeRequest(self.offlineService.customers, completionHandler: completionHandler)
    }

    // -------DataRequesterForEntity: ProductCategories -------
    func loadMyPrefixProductCategories(completionHandler: @escaping([MyPrefixProductCategory]?, Error?) -> Void) {
        self.executeRequest(self.service.productCategories, completionHandler: completionHandler)
    }

    // -------DataRequesterForEntity: SalesOrderItems -------
    func loadMyPrefixSalesOrderItems(completionHandler: @escaping([MyPrefixSalesOrderItem]?, Error?) -> Void) {
        self.executeRequest(self.service.salesOrderItems, completionHandler: completionHandler)
    }

    // -------DataRequesterForEntity: PurchaseOrderHeaders -------
    func loadMyPrefixPurchaseOrderHeaders(completionHandler: @escaping([MyPrefixPurchaseOrderHeader]?, Error?) -> Void) {
        self.executeRequest(self.service.purchaseOrderHeaders, completionHandler: completionHandler)
    }

    // -------DataRequesterForEntity: Products -------
    func loadMyPrefixProducts(completionHandler: @escaping([MyPrefixProduct]?, Error?) -> Void) {
        self.executeRequest(self.service.products, completionHandler: completionHandler)
    }

    private func executeRequest<T>(_ request: @escaping(DataQuery) throws -> [T], completionHandler: @escaping([T]?, Error?) -> Void) {
        DispatchQueue.global().async {
            if !self.storeOpend {
                let semaphore = DispatchSemaphore(value: 0)
                
                self.offlineService.open {
                    error in
                    
                    defer {
                        semaphore.signal()
                    }
                    
                    guard error == nil else {
                        self.logger.info("Could not open store", error: error)
                        return
                    }
                    
                    self.storeOpend = true
                    
                    self.offlineService.download {
                        error in
                        
                        guard error == nil else {
                            self.logger.info("Could not download store", error: error)
                            return
                        }
                    }
                }
                semaphore.wait()
            }
            
            let query = DataQuery().selectAll().top(20)
            do {
                let result = try request(query)
                completionHandler(result, nil)
            } catch let error {

                self.logger.info("Error happened in the downloading process. Error: \(error)")
                completionHandler(nil, error)
            }
        }
    }
}
