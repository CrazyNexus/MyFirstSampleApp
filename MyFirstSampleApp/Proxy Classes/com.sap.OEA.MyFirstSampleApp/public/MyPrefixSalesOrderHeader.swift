// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class MyPrefixSalesOrderHeader: EntityValue {
    public static let createdAt: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "CreatedAt")

    public static let currencyCode: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "CurrencyCode")

    public static let customerID: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "CustomerId")

    public static let grossAmount: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "GrossAmount")

    public static let lifeCycleStatus: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "LifeCycleStatus")

    public static let lifeCycleStatusName: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "LifeCycleStatusName")

    public static let netAmount: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "NetAmount")

    public static let salesOrderID: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "SalesOrderId")

    public static let taxAmount: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "TaxAmount")

    public static let customerDetails: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "CustomerDetails")

    public static let items: Property = MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader.property(withName: "Items")

    public init() {
        super.init(type: MyPrefixMyServiceClassMetadata.EntityTypes.salesOrderHeader)
    }

    open class func array(from: EntityValueList) -> Array<MyPrefixSalesOrderHeader> {
        return ArrayConverter.convert(from.toArray(), Array<MyPrefixSalesOrderHeader>())
    }

    open func copy() -> MyPrefixSalesOrderHeader {
        return CastRequired<MyPrefixSalesOrderHeader>.from(self.copyEntity())
    }

    open var createdAt: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: MyPrefixSalesOrderHeader.createdAt))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixSalesOrderHeader.createdAt, to: value)
        }
    }

    open var currencyCode: String? {
        get {
            return StringValue.optional(self.optionalValue(for: MyPrefixSalesOrderHeader.currencyCode))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixSalesOrderHeader.currencyCode, to: StringValue.of(optional: value))
        }
    }

    open var customerDetails: MyPrefixCustomer {
        get {
            return CastRequired<MyPrefixCustomer>.from(self.optionalValue(for: MyPrefixSalesOrderHeader.customerDetails))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixSalesOrderHeader.customerDetails, to: value)
        }
    }

    open var customerID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: MyPrefixSalesOrderHeader.customerID))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixSalesOrderHeader.customerID, to: StringValue.of(optional: value))
        }
    }

    open var grossAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: MyPrefixSalesOrderHeader.grossAmount))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixSalesOrderHeader.grossAmount, to: DecimalValue.of(optional: value))
        }
    }

    open var items: Array<MyPrefixSalesOrderItem> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: MyPrefixSalesOrderHeader.items)).toArray(), Array<MyPrefixSalesOrderItem>())
        }
        set(value) {
            MyPrefixSalesOrderHeader.items.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open class func key(salesOrderID: String?) -> EntityKey {
        return EntityKey().with(name: "SalesOrderId", value: StringValue.of(optional: salesOrderID))
    }

    open var lifeCycleStatus: String? {
        get {
            return StringValue.optional(self.optionalValue(for: MyPrefixSalesOrderHeader.lifeCycleStatus))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixSalesOrderHeader.lifeCycleStatus, to: StringValue.of(optional: value))
        }
    }

    open var lifeCycleStatusName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: MyPrefixSalesOrderHeader.lifeCycleStatusName))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixSalesOrderHeader.lifeCycleStatusName, to: StringValue.of(optional: value))
        }
    }

    open var netAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: MyPrefixSalesOrderHeader.netAmount))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixSalesOrderHeader.netAmount, to: DecimalValue.of(optional: value))
        }
    }

    open var old: MyPrefixSalesOrderHeader {
        get {
            return CastRequired<MyPrefixSalesOrderHeader>.from(self.oldEntity)
        }
    }

    open var salesOrderID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: MyPrefixSalesOrderHeader.salesOrderID))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixSalesOrderHeader.salesOrderID, to: StringValue.of(optional: value))
        }
    }

    open var taxAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: MyPrefixSalesOrderHeader.taxAmount))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixSalesOrderHeader.taxAmount, to: DecimalValue.of(optional: value))
        }
    }
}
