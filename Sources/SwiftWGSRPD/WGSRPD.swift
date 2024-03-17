import Foundation
import MapKit

/// A TDWG item including its code and its user friendly english name
///
/// Biodiversity Information Standards
/// https://www.tdwg.org
public struct TDWGItem: Codable {
    public var code: String
    public var name: String
}

/// A WGSRPD Item, including the first 3 TDWG levels and the calculated center of the area polygon
/// World Geographical Scheme for Recording Plant Distributions (WGSRPD)
/// https://www.tdwg.org/standards/wgsrpd/
public struct WGSRPDItem: Codable {
    public var tdwg1: TDWGItem
    public var tdwg2: TDWGItem
    public var tdwg3: TDWGItem
    
    public var center: CLLocationCoordinate2D
}

/// A container including a list of all available decoded `WGSRPDItem`s
public struct WGSRPD: Codable {
    public var items: [WGSRPDItem] = []
    
    /// The default instance of `WGSRPD`
    public static var `default` = WGSRPD()
    
    private init() {
        let decoder = JSONDecoder()
        guard let sourceFile = Bundle.module.url(forResource: "wdsrpd", withExtension: "json") else { return }
        do {
            let sourceData = try Data(contentsOf: sourceFile)
            self.items = try decoder.decode([WGSRPDItem].self, from: sourceData)
        } catch {
            self.items = []
        }
    }
}

extension WGSRPD {
    /// Returns the first item matching the given `level3Code` if found
    public func item(for level3Code: String) -> WGSRPDItem? {
        items.first(where: { $0.tdwg3.code == level3Code })
    }
}
