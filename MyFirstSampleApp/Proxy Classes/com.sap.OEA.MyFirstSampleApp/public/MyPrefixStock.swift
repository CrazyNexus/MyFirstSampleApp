// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class MyPrefixStock: EntityValue {
    public static let lotSize: Property = MyPrefixMyServiceClassMetadata.EntityTypes.stock.property(withName: "LotSize")

    public static let minStock: Property = MyPrefixMyServiceClassMetadata.EntityTypes.stock.property(withName: "MinStock")

    public static let productID: Property = MyPrefixMyServiceClassMetadata.EntityTypes.stock.property(withName: "ProductId")

    public static let quantity: Property = MyPrefixMyServiceClassMetadata.EntityTypes.stock.property(withName: "Quantity")

    public static let quantityLessMin: Property = MyPrefixMyServiceClassMetadata.EntityTypes.stock.property(withName: "QuantityLessMin")

    public static let updatedTimestamp: Property = MyPrefixMyServiceClassMetadata.EntityTypes.stock.property(withName: "UpdatedTimestamp")

    public static let productDetails: Property = MyPrefixMyServiceClassMetadata.EntityTypes.stock.property(withName: "ProductDetails")

    public init() {
        super.init(type: MyPrefixMyServiceClassMetadata.EntityTypes.stock)
    }

    open class func array(from: EntityValueList) -> Array<MyPrefixStock> {
        return ArrayConverter.convert(from.toArray(), Array<MyPrefixStock>())
    }

    open func copy() -> MyPrefixStock {
        return CastRequired<MyPrefixStock>.from(self.copyEntity())
    }

    open class func key(productID: String?) -> EntityKey {
        return EntityKey().with(name: "ProductId", value: StringValue.of(optional: productID))
    }

    open var lotSize: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: MyPrefixStock.lotSize))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixStock.lotSize, to: DecimalValue.of(optional: value))
        }
    }

    open var minStock: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: MyPrefixStock.minStock))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixStock.minStock, to: DecimalValue.of(optional: value))
        }
    }

    open var old: MyPrefixStock {
        get {
            return CastRequired<MyPrefixStock>.from(self.oldEntity)
        }
    }

    open var productDetails: MyPrefixProduct {
        get {
            return CastRequired<MyPrefixProduct>.from(self.optionalValue(for: MyPrefixStock.productDetails))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixStock.productDetails, to: value)
        }
    }

    open var productID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: MyPrefixStock.productID))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixStock.productID, to: StringValue.of(optional: value))
        }
    }

    open var quantity: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: MyPrefixStock.quantity))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixStock.quantity, to: DecimalValue.of(optional: value))
        }
    }

    open var quantityLessMin: Bool? {
        get {
            return BooleanValue.optional(self.optionalValue(for: MyPrefixStock.quantityLessMin))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixStock.quantityLessMin, to: BooleanValue.of(optional: value))
        }
    }

    open var updatedTimestamp: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: MyPrefixStock.updatedTimestamp))
        }
        set(value) {
            self.setOptionalValue(for: MyPrefixStock.updatedTimestamp, to: value)
        }
    }
}
