import Foundation
/// Defines a protocol with the same name as the file. SecureStoreQueryable forces the implementer to provide a query property defined as a dictionary typed as [String: Any]. Internally, your API only deals with those types of objects. More on that later.
public protocol SecureStoreQueryable {
  var query: [String: Any] { get }
}
/// For a keychain item of class kSecClassGenericPassword, the primary key is the combination of kSecAttrAccount and kSecAttrService. In other words, the tuple allows you to uniquely identify a generic password in the Keychain.
public struct GenericPasswordQueryable {
  let service: String
  let accessGroup: String?
  
  init(service: String, accessGroup: String? = nil) {
    self.service = service
    self.accessGroup = accessGroup
  }
}

extension GenericPasswordQueryable: SecureStoreQueryable {
  public var query: [String: Any] {
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassGenericPassword
    query[String(kSecAttrService)] = service
    // Access group if target environment is not simulator
    #if !targetEnvironment(simulator)
    if let accessGroup = accessGroup {
      query[String(kSecAttrAccessGroup)] = accessGroup
    }
    #endif
    return query
  }
}
/// For a keychain item of class kSecClassInternetPassword, the primary key is the combination of kSecAttrAccount, kSecAttrSecurityDomain, kSecAttrServer, kSecAttrProtocol, kSecAttrAuthenticationType, kSecAttrPort and kSecAttrPath. In other words, those values allow you to uniquely identify an internet password in the Keychain.
public struct InternetPasswordQueryable {
  let server: String
  let port: Int
  let path: String
  let securityDomain: String
  let internetProtocol: InternetProtocol
  let internetAuthenticationType: InternetAuthenticationType
}

extension InternetPasswordQueryable: SecureStoreQueryable {
  public var query: [String: Any] {
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassInternetPassword
    query[String(kSecAttrPort)] = port
    query[String(kSecAttrServer)] = server
    query[String(kSecAttrSecurityDomain)] = securityDomain
    query[String(kSecAttrPath)] = path
    query[String(kSecAttrProtocol)] = internetProtocol.rawValue
    query[String(kSecAttrAuthenticationType)] = internetAuthenticationType.rawValue
    return query
  }
}
